import 'package:flutter/material.dart';
import '../../../../injection_container.dart';
import '../../../theme/data/datasources/theme_local_data_source.dart';
import '../../domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource = sl<ThemeLocalDataSource>();

  @override
  Future<void> updatePrimaryColor(Color primaryColor, Color textColor) async {
    await localDataSource.cachePrimaryColor(primaryColor);
    await localDataSource.cacheTextColor(textColor);
  }

  @override
  Future<void> updateThemeMode(bool isDark) async {
    await localDataSource.cacheThemeMode(isDark);
  }

  @override
  Color? getPrimaryColor() {
    return localDataSource.getPrimaryColor();
  }

  @override
  Color? getTextColor() {
    return localDataSource.getTextColor();
  }

  @override
  bool? getThemeMode() {
    return localDataSource.getThemeMode();
  }
}
