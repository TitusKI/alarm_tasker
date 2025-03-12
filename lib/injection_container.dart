import 'package:alarm_tasker/core/util/adapters/color_adapter.dart';
import 'package:alarm_tasker/features/tasks/data/models/subtask_model.dart';
import 'package:alarm_tasker/features/tasks/domain/repositories/task_repository.dart';
import 'package:alarm_tasker/features/tasks/domain/usecases/add_task.dart';
import 'package:alarm_tasker/features/tasks/domain/usecases/get_tasks.dart';
import 'package:alarm_tasker/features/tasks/domain/usecases/update_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';

import 'features/tasks/data/datasources/task_local_data_source.dart';
import 'features/tasks/data/models/task_model.dart';
import 'features/tasks/data/repositories/task_repository_impl.dart';
import 'features/tasks/domain/usecases/delete_task.dart';
import 'features/theme/data/datasources/theme_local_data_source.dart';
import 'features/theme/data/repositories/theme_repository_impl.dart';
import 'features/theme/domain/repositories/theme_repository.dart';
import 'features/theme/domain/usecases/get_theme.dart';
import 'features/theme/domain/usecases/toggle_theme_mode.dart';
import 'features/theme/domain/usecases/update_theme.dart';
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
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(SubTaskAdapter());
  // Open the box
  final box = await Hive.openBox('theme_box');
  final taskBox = await Hive.openBox<Task>('tasks_box');
  // Data Sources
  sl.registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeLocalDataSourceImpl(box));
  sl.registerLazySingleton(() => TaskLocalDataSource(taskBox));
  // Repositories,
  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl());
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl());
  // Use cases
  sl.registerLazySingleton(() => GetThemeUsecase());
  sl.registerLazySingleton(() => UpdateThemeUsecase());
  sl.registerLazySingleton(() => ToggleThemeModeUsecase());
  // task usecases
  sl.registerLazySingleton(() => AddTaskUsecase());
  sl.registerLazySingleton(() => DeleteTaskUsecase());
  sl.registerLazySingleton(() => UpdateTaskUsecase());
  sl.registerLazySingleton(() => GetTasksUsecase());
  // Cubits
  sl.registerFactory(() => ThemeCubit());
}
