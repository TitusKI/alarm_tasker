import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'features/tasks/data/datasources/theme_local_data_source.dart';
import 'features/tasks/data/repositories/theme_repository_impl.dart';
import 'features/tasks/domain/repositories/theme_repository.dart';
import 'features/tasks/domain/usecases/get_theme.dart';
import 'features/tasks/domain/usecases/toggle_theme_mode.dart';
import 'features/tasks/domain/usecases/update_theme.dart';
import 'features/theme/presentation/cubit/theme_cubit.dart';

final GetIt sl = GetIt.instance;
Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  final box = await Hive.openBox('theme_box');
  // Data Sources
  sl.registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeLocalDataSourceImpl(box));
  // Repositories,
  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl());
  // Use cases
  sl.registerLazySingleton(() => GetThemeUsecase());
  sl.registerLazySingleton(() => UpdateThemeUsecase());
  sl.registerLazySingleton(() => ToggleThemeModeUsecase());
  // Cubits
  sl.registerFactory(() => ThemeCubit());
}
