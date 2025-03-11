import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

abstract class ThemeLocalDataSource {
  Future<void> cachePrimaryColor(Color color);
  Future<void> cacheThemeMode(bool isDark);
  Color? getPrimaryColor();
  bool? getThemeMode();
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final Box _box;

  ThemeLocalDataSourceImpl(this._box);

  static const String primaryColorKey = 'primary_color';
  static const String themeModeKey = 'is_dark_mode';

  @override
  Future<void> cachePrimaryColor(Color color) async {
    await _box.put(primaryColorKey, color);
  }

  @override
  Future<void> cacheThemeMode(bool isDark) async {
    await _box.put(themeModeKey, isDark);
  }

  @override
  Color? getPrimaryColor() {
    final colorValue = _box.get(primaryColorKey);
    return colorValue != null ? Color(colorValue) : null;
  }

  @override
  bool? getThemeMode() {
    return _box.get(themeModeKey);
  }
}
