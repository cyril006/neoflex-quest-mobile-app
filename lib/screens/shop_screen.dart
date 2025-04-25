import 'package:flutter/material.dart';
import 'package:neoquest/theme/neoquest.dart';
import 'package:neoquest/widgets/custom_button.dart';

enum Category { all, booster, tool, exclusive }

class Item {
  final String name;
  final int price;
  final String description;
  final Category category;
  bool purchased;

  Item({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    this.purchased = false,
  });
}

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _currency = 150;
  Category _selectedCategory = Category.all;
  final List<Item> _items = [
    Item(
      name: 'Усилитель скорости',
      price: 40,
      description: 'Придаёт +20% к скорости прохождения квестов на 1 час.',
      category: Category.booster,
    ),
    Item(
      name: 'Мастер-ключ',
      price: 75,
      description: 'Открывает любые двери в виртуальных миссиях.',
      category: Category.tool,
    ),
    Item(
      name: 'Золотой компас',
      price: 120,
      description: 'Компас, который указывает на ближайшую точку интереса.',
      category: Category.exclusive,
    ),
    Item(
      name: 'Энергетический стимулятор',
      price: 30,
      description: 'Восстанавливает энергию на 50 единиц.',
      category: Category.booster,
    ),
    Item(
      name: 'Секретный сундук',
      price: 90,
      description: 'Содержит случайный редкий артефакт.',
      category: Category.exclusive,
    ),
  ];

  void _selectCategory(Category cat) {
    setState(() => _selectedCategory = cat);
  }

  void _buyItem(Item item) {
    if (item.purchased) return;
    if (_currency < item.price) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Недостаточно монет 😔')),
      );
      return;
    }
    setState(() {
      _currency -= item.price;
      item.purchased = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Успешно куплено: ${item.name} 🎉'),
        backgroundColor: NeoQuestTheme.accentColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filtered = _selectedCategory == Category.all
        ? _items
        : _items.where((i) => i.category == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: NeoQuestTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: NeoQuestTheme.primaryColor,
        title: Text(
          'Магазин',
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.yellow[700]),
                const SizedBox(width: 4),
                Text(
                  '$_currency',
                  style:
                      theme.textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category filter chips with light background
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Wrap(
              spacing: 8,
              children: Category.values.map((cat) {
                final label = cat == Category.all
                    ? 'Все'
                    : cat == Category.booster
                        ? 'Бустеры'
                        : cat == Category.tool
                            ? 'Инструменты'
                            : 'Эксклюзив';
                final selected = _selectedCategory == cat;
                return ChoiceChip(
                  label: Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color:
                          selected ? Colors.white : NeoQuestTheme.primaryColor,
                    ),
                  ),
                  selected: selected,
                  backgroundColor: Colors.white,
                  selectedColor: NeoQuestTheme.accentColor,
                  onSelected: (_) => _selectCategory(cat),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final item = filtered[index];
                return AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: item.purchased ? 1.05 : 1.0,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            item.category == Category.exclusive
                                ? Icons.star
                                : item.category == Category.tool
                                    ? Icons.build
                                    : Icons.local_fire_department,
                            size: 36,
                            color: NeoQuestTheme.accentColor,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name,
                                    style: theme.textTheme.titleLarge),
                                const SizedBox(height: 4),
                                Text(item.description,
                                    style: theme.textTheme.bodyMedium),
                                const SizedBox(height: 8),
                                Text('Цена: ${item.price} монет',
                                    style: theme.textTheme.bodyMedium),
                              ],
                            ),
                          ),
                          CustomButton(
                            text: item.purchased ? 'Куплено' : 'Купить',
                            onPressed: () => _buyItem(item),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
