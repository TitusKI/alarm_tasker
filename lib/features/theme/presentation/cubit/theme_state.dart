import 'package:flutter/material.dart';

class ThemeState {
  final Color primaryColor;
  final bool isDarkMode;

  ThemeState({
    required this.primaryColor,
    required this.isDarkMode,
  });

  ThemeState copyWith({Color? primaryColor, bool? isDarkMode}) {
    return ThemeState(
      primaryColor: primaryColor ?? this.primaryColor,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
