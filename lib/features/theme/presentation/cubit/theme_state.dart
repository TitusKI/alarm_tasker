import 'package:flutter/material.dart';

class ThemeState {
  final Color primaryColor;
  final Color textColor;
  final bool isDarkMode;

  ThemeState({
    required this.primaryColor,
    required this.isDarkMode,
    required this.textColor,
  });

  ThemeState copyWith(
      {Color? primaryColor, bool? isDarkMode, Color? textColor}) {
    return ThemeState(
      primaryColor: primaryColor ?? this.primaryColor,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      textColor: textColor ?? this.textColor,
    );
  }
}
