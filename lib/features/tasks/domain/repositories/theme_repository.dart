import 'package:flutter/material.dart';

abstract class ThemeRepository {
  Future<void> updatePrimaryColor(Color color);
  Future<void> updateThemeMode(bool isDark);
  Color? getPrimaryColor();
  bool? getThemeMode();
}
