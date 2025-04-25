import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:async';
import 'package:neoquest/theme/neoquest.dart';
import 'package:neoquest/widgets/custom_button.dart';

class OfficeSimulatorScreen extends StatefulWidget {
  const OfficeSimulatorScreen({Key? key}) : super(key: key);

  @override
  State<OfficeSimulatorScreen> createState() => _OfficeSimulatorScreenState();
}

class _OfficeSimulatorScreenState extends State<OfficeSimulatorScreen> {
  final _confettiController =
      ConfettiController(duration: const Duration(seconds: 2));
  int _currentStep = 0;

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  final List<_SimStep> _steps = [
    _SimStep(
      title: 'Вход и первое впечатление',
      description:
          '🚪 Ты подходишь к стеклянным дверям компании NeoQuest. Охранник просит сканировать пропуск. Один неверный код — и тревога сработает.',
      actionLabel: 'Сканировать пропуск',
      miniGame: _scanBadgeGame,
    ),
    _SimStep(
      title: 'Поиск улик',
      description:
          '🔎 Ты оказываешься в просторном кабинете директора. На столе — записки, USB‑накопитель и открыт ноутбук.',
      actionLabel: 'Исследовать стол',
      miniGame: _memoryClueGame,
    ),
    _SimStep(
      title: 'Взлом системы',
      description:
          '💻 На экране появляется окно авторизации. Пароль неизвестен, но ты можешь попытаться взломать замок с помощью логической мини‑игры.',
      actionLabel: 'Начать взлом',
      miniGame: _hackingSliderGame,
    ),
    _SimStep(
      title: 'Отправка отчёта',
      description:
          '📨 Данные собраны. В отчёте нужно расставить приоритеты важных фактов. Упорядочь события по хронологии.',
      actionLabel: 'Составить отчёт',
      miniGame: _orderingGame,
    ),
  ];

  void _onStepContinue() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    } else {
      _confettiController.play();
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) setState(() => _currentStep--);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: NeoQuestTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: NeoQuestTheme.primaryColor,
        title: Text('Office Detective',
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Stepper(
            currentStep: _currentStep,
            type: StepperType.vertical,
            onStepContinue: () async {
              await _steps[_currentStep].miniGame(context);
              _onStepContinue();
            },
            onStepCancel: _onStepCancel,
            controlsBuilder: (context, details) {
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    CustomButton(
                      text: _currentStep < _steps.length - 1
                          ? 'Выполнить'
                          : 'Завершить',
                      onPressed: details.onStepContinue!,
                    ),
                    const SizedBox(width: 8),
                    if (_currentStep > 0)
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: Text('Назад', style: theme.textTheme.bodyMedium),
                      ),
                  ],
                ),
              );
            },
            steps: _steps.map((step) {
              int index = _steps.indexOf(step);
              return Step(
                title: Text(step.title, style: theme.textTheme.bodyLarge),
                content:
                    Text(step.description, style: theme.textTheme.bodyMedium),
                isActive: _currentStep >= index,
                state: _currentStep > index
                    ? StepState.complete
                    : StepState.indexed,
              );
            }).toList(),
          ),
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
}

// Definition of a simulation step with an attached mini-game
class _SimStep {
  final String title;
  final String description;
  final String actionLabel;
  final Future<void> Function(BuildContext) miniGame;

  _SimStep({
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.miniGame,
  });
}

// Example mini-games:
Future<void> _scanBadgeGame(BuildContext context) async {
  // Simple dialog simulation
  return showDialog(
    context: context,
    builder: (c) => AlertDialog(
      title: const Text('Сканирование пропуска'),
      content: const Text('Вставьте пропуск и дождитесь результата...'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(c),
          child: const Text('Готово'),
        ),
      ],
    ),
  );
}

Future<void> _memoryClueGame(BuildContext context) async {
  List<String> clues = ['USB', 'Записка'];
  return showDialog(
    context: context,
    builder: (c) => AlertDialog(
      title: const Text('Найдите подсказки'),
      content: Text(
          'Вспомните, какие два предмета вы видели: ${clues.join(' и ')}.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(c),
          child: const Text('Да, это они'),
        ),
      ],
    ),
  );
}

Future<void> _hackingSliderGame(BuildContext context) async {
  double val = 0.0;
  return showDialog(
    context: context,
    builder: (c) => StatefulBuilder(
      builder: (c, setState) => AlertDialog(
        title: const Text('Мини‑игра: взлом'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Перетащите ползунок на 80%'),
            Slider(
              value: val,
              onChanged: (v) => setState(() => val = v),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: const Text('Проверить'),
          ),
        ],
      ),
    ),
  );
}

Future<void> _orderingGame(BuildContext context) async {
  List<String> events = ['Взлом системы', 'Вход в офис', 'Отправка отчёта'];
  return showDialog(
    context: context,
    builder: (c) => AlertDialog(
      title: const Text('Упорядочьте события'),
      content: const Text(
          'Порядок: Вход в офис -> Взлом системы -> Отправка отчёта'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(c),
          child: const Text('Готово'),
        ),
      ],
    ),
  );
}
