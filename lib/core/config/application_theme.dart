import 'package:flutter/material.dart';

class ApplicationTheme {
  static const Color primaryColor = Color(0xFFEF9B28);
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(
          size: 32,
        ),
        unselectedIconTheme: IconThemeData(
          size: 28,
        ),
        unselectedItemColor: Colors.white,
        unselectedLabelStyle: TextStyle(
            fontFamily: "Inter",
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white),
        selectedLabelStyle: TextStyle(
            fontFamily: "Inter",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white)),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      onSecondary: const Color(0xFF0E382F),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: "Inter",
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFFEF9B28),
      ),
      titleLarge: TextStyle(
        fontFamily: "Inter",
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: "Inter",
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Inter",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Inter",
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: "Inter",
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    ),
  );
}
