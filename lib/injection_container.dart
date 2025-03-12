import 'package:alarm_tasker/core/util/adapters/color_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';

import 'features/theme/data/datasources/theme_local_data_source.dart';
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
  if (kIsWeb) {
    await Hive.initFlutter();
  } else {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(path.join(appDocumentDirectory.path, 'hive'));
  }
  // Register the colorAdapter
  Hive.registerAdapter(ColorAdapter());
  // Open the box
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
