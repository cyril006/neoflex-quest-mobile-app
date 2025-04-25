import 'package:flutter/material.dart';

class NeoQuestTheme {
  // Gamified NeoFlex Quest Palette
  static const Color primaryColor = Color(0xFF1E1E2C); // Dark midnight
  static const Color secondaryColor = Color(0xFF28293E); // Deep space
  static const Color accentColor = Color(0xFF42A5F5); // Energetic cyan
  static const Color highlightColor = Color(0xFFFFC107); // Bright amber
  static const Color backgroundColor = Color(0xFFF4F5F9); // Light quest map
  static const Color dangerColor = Color(0xFFE53935); // Quiz wrong answers

  static final ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: accentColor,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: primaryColor,
      error: dangerColor,
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: secondaryColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: accentColor,
      ),
      iconTheme: IconThemeData(color: accentColor),
      centerTitle: true,
    ),
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      titleLarge: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      bodyLarge: const TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        color: primaryColor,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 14,
        color: primaryColor.withOpacity(0.8),
      ),
      labelLarge: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentColor,
        side: const BorderSide(color: accentColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: highlightColor,
      foregroundColor: Colors.white,
      elevation: 6,
    ),
    iconTheme: const IconThemeData(
      color: accentColor,
      size: 24,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: secondaryColor.withOpacity(0.4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: dangerColor, width: 2),
      ),
      hintStyle: TextStyle(color: primaryColor.withOpacity(0.5)),
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: secondaryColor,
      selectedColor: accentColor,
      labelStyle: TextStyle(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: StadiumBorder(),
    ),
    dividerTheme: DividerThemeData(
      color: secondaryColor.withOpacity(0.5),
      thickness: 1,
      space: 24,
    ),
  );
}
