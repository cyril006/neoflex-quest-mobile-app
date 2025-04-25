import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:neoquest/widgets/custom_button.dart';
import 'package:neoquest/theme/neoquest.dart';

class CompanyHistoryScreen extends StatefulWidget {
  const CompanyHistoryScreen({Key? key}) : super(key: key);

  @override
  _CompanyHistoryScreenState createState() => _CompanyHistoryScreenState();
}

class _CompanyHistoryScreenState extends State<CompanyHistoryScreen> {
  final List<int> _years = [2015, 2017, 2019, 2021, 2023, 2025];
  int _selectedIndex = 0;

  final Map<int, String> _events = {
    2015: 'Группа энтузиастов запустила первый прототип платформы NeoFlex.',
    2017:
        'Запуск мобильного приложения и первая тысяча активных пользователей.',
    2019:
        'Интеграция AI-модуля для персональных рекомендаций и роста вовлеченности.',
    2021: 'Глобальная экспансия: офисы в Лондоне и Сингапуре.',
    2023: 'Выпуск SDK для разработчиков и открытие партнерской сети.',
    2025:
        'NeoFlex достиг 1 миллиона пользователей и получил премию Tech Innovator.',
  };

  Future<void> _openWeb() async {
    const uri = 'https://neoquest.example.com/history';
    if (!await launchUrl(Uri.parse(uri))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не удалось открыть ссылку',
              style: TextStyle(color: NeoQuestTheme.backgroundColor)),
          backgroundColor: NeoQuestTheme.dangerColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: NeoQuestTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: NeoQuestTheme.primaryColor,
        elevation: 0,
        title: Text('Хронология NeoQuest',
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _years.length,
              itemBuilder: (context, index) {
                final year = _years[index];
                final selected = index == _selectedIndex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: selected
                          ? NeoQuestTheme.accentColor
                          : NeoQuestTheme.secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color:
                                    NeoQuestTheme.accentColor.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        year.toString(),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: selected
                              ? Colors.white
                              : NeoQuestTheme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, anim) =>
                  FadeTransition(opacity: anim, child: child),
              child: Padding(
                key: ValueKey<int>(_selectedIndex),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.timeline,
                      size: 48,
                      color: NeoQuestTheme.highlightColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _years[_selectedIndex].toString(),
                      style: theme.textTheme.titleLarge
                          ?.copyWith(color: NeoQuestTheme.primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _events[_years[_selectedIndex]]!,
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    CustomButton(
                      text: 'Узнать подробнее',
                      onPressed: _openWeb,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
