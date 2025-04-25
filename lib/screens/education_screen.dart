import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'package:neoquest/theme/neoquest.dart';
import 'package:neoquest/widgets/custom_button.dart';

class Course {
  final String title;
  final String description;
  final IconData icon;
  bool isCompleted;

  Course({
    required this.title,
    required this.description,
    required this.icon,
    this.isCompleted = false,
  });
}

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final List<Course> _courses = [
    Course(
      title: 'Мастер-класс Генерации Идей',
      description:
          'Откройте в себе поток креативности с техниками мозгового штурма и визуализации.',
      icon: Icons.auto_mode,
    ),
    Course(
      title: 'Стратегии Рыночного Взлёта',
      description:
          'Изучите проверенные стратегии вывода продукта на новый уровень продаж.',
      icon: Icons.rocket_launch,
    ),
    Course(
      title: 'Аналитика как Суперсила',
      description:
          'Разберитесь в ключевых метриках и научитесь принимать решения на основе данных.',
      icon: Icons.show_chart,
    ),
    Course(
      title: 'Лидерство в Digital-Мире',
      description:
          'Освойте навыки управления онлайн-командами и разработки цифровых стратегий.',
      icon: Icons.computer,
    ),
  ];

  int _currentIndex = 0;
  final _confettiController =
      ConfettiController(duration: const Duration(seconds: 2));

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _toggleCompleted() {
    setState(() {
      _courses[_currentIndex].isCompleted =
          !_courses[_currentIndex].isCompleted;
    });
  }

  void _next() {
    if (_currentIndex < _courses.length - 1) {
      setState(() => _currentIndex++);
    } else {
      _confettiController.play();
    }
  }

  void _prev() {
    if (_currentIndex > 0) setState(() => _currentIndex--);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool allDone = _courses.every((c) => c.isCompleted);

    return Scaffold(
      backgroundColor: NeoQuestTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: NeoQuestTheme.primaryColor,
        elevation: 0,
        title: Text(
          'Академия NeoQuest',
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          allDone ? _buildCompletionView(theme) : _buildCourseView(theme),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 20,
              colors: const [
                NeoQuestTheme.accentColor,
                NeoQuestTheme.highlightColor,
                NeoQuestTheme.primaryColor,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseView(ThemeData theme) {
    final course = _courses[_currentIndex];
    final progress = (_currentIndex + 1) / _courses.length;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: progress,
            backgroundColor: NeoQuestTheme.secondaryColor.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation(NeoQuestTheme.accentColor),
            minHeight: 8,
          ),
          const SizedBox(height: 12),
          Text(
            'Курс ${_currentIndex + 1} из ${_courses.length}',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          // Course card
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(course.icon, size: 72, color: NeoQuestTheme.accentColor),
                  const SizedBox(height: 16),
                  Text(course.title,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(color: NeoQuestTheme.primaryColor)),
                  const SizedBox(height: 12),
                  Text(course.description,
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: course.isCompleted ? 'Пройдено' : 'Отметить',
                    onPressed: _toggleCompleted,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          // Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: _currentIndex > 0 ? _prev : null,
                child: const Text('Назад'),
              ),
              TextButton(
                onPressed: _next,
                child: Text(
                  _currentIndex < _courses.length - 1 ? 'Далее' : 'Завершить',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionView(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events,
                size: 80, color: NeoQuestTheme.highlightColor),
            const SizedBox(height: 16),
            Text('Поздравляем!',
                style: theme.textTheme.headlineSmall
                    ?.copyWith(color: NeoQuestTheme.primaryColor)),
            const SizedBox(height: 8),
            Text('Вы успешно завершили все курсы! 🎉',
                style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Вернуться на главную',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
