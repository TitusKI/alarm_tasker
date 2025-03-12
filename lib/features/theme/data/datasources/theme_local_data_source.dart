import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

abstract class ThemeLocalDataSource {
  Future<void> cachePrimaryColor(Color color);
  Future<void> cacheTextColor(Color color);

  Future<void> cacheThemeMode(bool isDark);
  Color? getPrimaryColor();
  Color? getTextColor();

  bool? getThemeMode();
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final Box _box;

  ThemeLocalDataSourceImpl(this._box);

  static const String primaryColorKey = 'primary_color';
  static const String textColorKey = 'text_color';

  static const String themeModeKey = 'is_dark_mode';

  @override
  Future<void> cachePrimaryColor(Color primaryColor) async {
    await _box.put(primaryColorKey, primaryColor);
  }

  @override
  Future<void> cacheTextColor(Color textColor) async {
    await _box.put(textColorKey, textColor);
  }

  @override
  Future<void> cacheThemeMode(bool isDark) async {
    await _box.put(themeModeKey, isDark);
  }

  @override
  Color? getPrimaryColor() {
    final colorValue = _box.get(primaryColorKey);
    return colorValue != null ? colorValue as Color : null;
  }

  @override
  Color? getTextColor() {
    final colorValue = _box.get(textColorKey);
    return colorValue != null ? colorValue as Color : null;
  }

  @override
  bool? getThemeMode() {
    return _box.get(themeModeKey);
  }
}
