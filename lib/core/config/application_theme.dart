import 'package:barista/core/services/web_service.dart';
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.white,
      selectedIconTheme: const IconThemeData(
        size: 32,
      ),
      unselectedIconTheme: const IconThemeData(
        size: 28,
      ),
      unselectedItemColor: Colors.white,
      unselectedLabelStyle: TextStyle(
        fontFamily: WebServices().lang == "en" ? "Inter" : "El Messi-ri",
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      selectedLabelStyle: TextStyle(
        fontFamily: WebServices().lang == "en" ? "Inter" : "El Messi-ri",
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      onSecondary: const Color(0xFF0E382F),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontFamily: WebServices().lang == "en" ? "Inter" : "El Messi-ri",
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: const Color(0xFFEF9B28),
      ),
      titleLarge: TextStyle(
        fontFamily: WebServices().lang == "en" ? "Inter" : "El Messi-ri",
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: WebServices().lang == "en" ? "Inter" : "El Messi-ri",
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: WebServices().lang == "en" ? "Inter" : "El Messi-ri",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: WebServices().lang == "en" ? "Inter" : "El Messi-ri",
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: WebServices().lang == "en" ? "Inter" : "El Messi-ri",
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    ),
  );
}
