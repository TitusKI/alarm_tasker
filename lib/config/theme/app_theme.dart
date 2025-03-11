import 'package:flutter/material.dart';

ThemeData getAppTheme(Color primaryColor, bool isDarkMode) {
  return ThemeData(
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: isDarkMode ? Brightness.dark : Brightness.light),
  );
}
