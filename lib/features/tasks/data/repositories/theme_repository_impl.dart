import 'package:flutter/material.dart';
import '../../../../injection_container.dart';
import '../datasources/theme_local_data_source.dart';
import '../../domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource = sl<ThemeLocalDataSource>();

  @override
  Future<void> updatePrimaryColor(Color color) async {
    await localDataSource.cachePrimaryColor(color);
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
  bool? getThemeMode() {
    return localDataSource.getThemeMode();
  }
}
