import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'cairo',
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: Colors.black),
    primaryColor: AppColor.primeColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primeColor,
      brightness: Brightness.light, // Ensure brightness matches
    ),
    scaffoldBackgroundColor: AppColor.lightBackgroundColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColor.text),
      bodyMedium: TextStyle(color: AppColor.text),
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.colorBottomBar,
      selectedItemColor: AppColor.primeColor,
      unselectedItemColor: Colors.black,
      unselectedIconTheme: const IconThemeData(color: Colors.black),
      elevation: 8,
    ),
    inputDecorationTheme: _inputDecorationTheme(AppColor.fillTextField),
    bottomAppBarTheme: BottomAppBarTheme(color: AppColor.colorBottomBar),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'cairo',
    brightness: Brightness.dark,
    iconTheme: const IconThemeData(color: Colors.white),
    primaryColor: const Color(0xff1b8f73),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primeColor,
      brightness: Brightness.dark, // Ensure brightness matches
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.amber),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Color.fromARGB(255, 232, 14, 14)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF2B2B2B),
      selectedItemColor: AppColor.primeColor,
      unselectedItemColor: Colors.white,
      unselectedIconTheme: IconThemeData(color: Colors.white),
      elevation: 8,
    ),
    inputDecorationTheme: _inputDecorationTheme(const Color(0xff1e1e1e)),
    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF2B2B2B)),
  );

  static InputDecorationTheme _inputDecorationTheme(Color fillColor) {
    return InputDecorationTheme(
      fillColor: fillColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
