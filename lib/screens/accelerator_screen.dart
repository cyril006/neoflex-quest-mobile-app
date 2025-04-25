import 'package:flutter/material.dart';
import 'package:neoquest/widgets/custom_button.dart';
import 'package:neoquest/theme/neoquest.dart';

class AcceleratorScreen extends StatefulWidget {
  const AcceleratorScreen({Key? key}) : super(key: key);

  @override
  _AcceleratorScreenState createState() => _AcceleratorScreenState();
}

class _AcceleratorScreenState extends State<AcceleratorScreen> {
  final _pageController = PageController(viewportFraction: 0.8);
  int _currentCard = 0;

  final List<Map<String, String>> _mentors = [
    {'name': 'Анна Смирнова', 'topic': 'UX/UI Дизайн'},
    {'name': 'Иван Петров', 'topic': 'Маркетинговые стратегии'},
    {'name': 'Ольга Кузнецова', 'topic': 'Финансовые модели'},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const progress = 0.45;

    return Scaffold(
      backgroundColor: NeoQuestTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: NeoQuestTheme.primaryColor,
        elevation: 0,
        title: Text(
          'NeoFlex Accelerator',
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🚀 Начни свой путь развития',
                style: theme.textTheme.displayLarge,
              ),
              const SizedBox(height: 16),

              // Progress Indicator
              Text(
                'Прогресс заявки',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: NeoQuestTheme.secondaryColor.withOpacity(0.3),
                valueColor:
                    const AlwaysStoppedAnimation(NeoQuestTheme.accentColor),
                minHeight: 10,
              ),
              const SizedBox(height: 4),
              Text(
                '${(progress * 100).toInt()}% завершено',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Mentors Carousel
              Text(
                'Твои наставники',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _mentors.length,
                  onPageChanged: (i) => setState(() => _currentCard = i),
                  itemBuilder: (context, i) {
                    final mentor = _mentors[i];
                    final isActive = i == _currentCard;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(
                          horizontal: isActive ? 8 : 16,
                          vertical: isActive ? 0 : 16),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mentor['name']!,
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            mentor['topic']!,
                            style: theme.textTheme.bodyLarge,
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              isActive ? Icons.star : Icons.star_border,
                              color: NeoQuestTheme.highlightColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),

              // Apply Button
              Center(
                child: CustomButton(
                  text: 'Подать заявку',
                  onPressed: () => _showApplicationDialog(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showApplicationDialog(BuildContext context) {
    final nameCtl = TextEditingController();
    final emailCtl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Заявка на Accelerator',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameCtl,
                decoration: InputDecoration(
                  hintText: 'Имя',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                validator: (v) => (v ?? '').length < 2 ? 'Введите имя' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailCtl,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                validator: (v) =>
                    RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v ?? '')
                        ? null
                        : 'Неверный email',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена',
                style: TextStyle(color: NeoQuestTheme.primaryColor)),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Заявка отправлена!',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: NeoQuestTheme.accentColor,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: NeoQuestTheme.accentColor,
            ),
            child:
                const Text('Отправить', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
