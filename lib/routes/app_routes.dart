import 'package:flutter/material.dart';
import 'package:neoquest/screens/home_screen.dart';
import 'package:neoquest/screens/shop_screen.dart';
import 'package:neoquest/screens/accelerator_screen.dart';
import 'package:neoquest/screens/education_screen.dart';
import 'package:neoquest/screens/history_screen.dart';
import 'package:neoquest/screens/office_simulation.dart';

class AppRoutes {
  static const String home = '/';
  static const String shop = '/shop';
  static const String accelerator = '/accelerator';
  static const String education = '/education';
  static const String history = '/history';
  static const String quest = '/quest';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    shop: (context) => const ShopScreen(),
    accelerator: (context) => const AcceleratorScreen(),
    education: (context) => const EducationScreen(),
    history: (context) => const CompanyHistoryScreen(),
    quest: (context) => const OfficeSimulatorScreen()
  };
}
