import 'package:flutter/material.dart';

abstract class ThemeRepository {
  Future<void> updatePrimaryColor(Color primaryColor, Color textColor);
  Future<void> updateThemeMode(bool isDark);
  Color? getPrimaryColor();
  Color? getTextColor();
  bool? getThemeMode();
}
