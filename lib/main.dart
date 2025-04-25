import 'package:flutter/material.dart';
import 'package:neoquest/routes/app_routes.dart';
import 'package:neoquest/theme/neoquest.dart';

void main() {
  runApp(const QuestGuideApp());
}

class QuestGuideApp extends StatelessWidget {
  const QuestGuideApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quest Guide',
      // Статическое свойство темы
      theme: NeoQuestTheme.theme,
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) {
        final builder = AppRoutes.routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(builder: builder, settings: settings);
        }
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
      },
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Ошибка 404: Страница не найдена',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
        ),
      ),
    );
  }
}
