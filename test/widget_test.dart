// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_test/flutter_test.dart';
import 'package:neoquest/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Home screen UI test', (WidgetTester tester) async {
    // Загружаем приложение
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Проверяем, что главный экран содержит заголовок
    expect(find.text("NeoQuest – Главное меню"), findsOneWidget);

    // Проверяем наличие кнопок
    expect(find.text("Начать квест"), findsOneWidget);
    expect(find.text("Магазин"), findsOneWidget);

    // Тестируем переход на экран магазина
    await tester.tap(find.text("Магазин"));
    await tester.pumpAndSettle();

    // Проверяем, что заголовок экрана магазина корректный
    expect(find.text("NeoQuest – Магазин"), findsOneWidget);
  });
}
