import 'package:alarm_tasker/core/util/adapters/color_adapter.dart';
import 'package:alarm_tasker/features/tasks/data/datasources/db_constant.dart';
import 'package:alarm_tasker/features/tasks/domain/repositories/subtask_repository.dart';
import 'package:alarm_tasker/features/tasks/domain/repositories/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';

import 'features/tasks/data/datasources/initialize_db.dart';
import 'features/tasks/data/datasources/sub_task_local_data_source.dart';
import 'features/tasks/data/datasources/subtask_titles_ds.dart';
import 'features/tasks/data/datasources/task_local_data_source.dart';
import 'features/tasks/data/repositories/subtask_repo_impl.dart';
import 'features/tasks/data/repositories/subtask_title_repo_impl.dart';
import 'features/tasks/data/repositories/task_repository_impl.dart';
import 'features/tasks/domain/repositories/subtask_title_repo.dart';
import 'features/tasks/domain/usecases/subtask_title_usecase.dart';
import 'features/tasks/domain/usecases/subtask_usecase.dart';
import 'features/tasks/domain/usecases/task_usecase.dart';
import 'features/tasks/presentation/cubit/subtask_titles_cubit.dart';
import 'features/tasks/presentation/cubit/subtasks_cubit.dart';
import 'features/tasks/presentation/cubit/tasks_cubit.dart';
import 'features/tasks/presentation/cubit/tasks_w_subtask_cubit.dart';
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
  final database = await initializeDatabase();

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
  final constBox = await Hive.openBox('constant_box');
  sl.registerSingleton(database);
  // Data Sources
  sl.registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeLocalDataSourceImpl(box));
  sl.registerLazySingleton<ConstantLocalDataSource>(
      () => ConstantLocalDataSourceImpl(constBox));
  sl.registerLazySingleton(() => TaskLocalDataSource(database));
  sl.registerLazySingleton(() => SubTaskLocalDataSource(database));

  sl.registerLazySingleton(() => SubTaskTitlesDataSource(database));

  // Repositories,
  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl());
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl());
  sl.registerLazySingleton<SubTaskRepository>(() => SubTaskRepositoryImpl());
  sl.registerLazySingleton<SubTaskTitleRepository>(
      () => SubTaskTitleRepositoryImpl());
  // Use cases
  sl.registerLazySingleton(() => GetThemeUsecase());
  sl.registerLazySingleton(() => UpdateThemeUsecase());
  sl.registerLazySingleton(() => ToggleThemeModeUsecase());
  // task usecases
  sl.registerLazySingleton(() => AddTaskUsecase());
  sl.registerLazySingleton(() => DeleteTaskUsecase());
  sl.registerLazySingleton(() => UpdateTaskUsecase());
  sl.registerLazySingleton(() => GetTasksUsecase());

  // subtasktitle usecases
  sl.registerLazySingleton(() => AddSubTaskTitleUsecase());
  sl.registerLazySingleton(() => DeleteSubTaskTitleUsecase());
  sl.registerLazySingleton(() => UpdateSubTaskTitleUsecase());
  sl.registerLazySingleton(() => GetSubTasksTitleUsecase());
//sub task usecases
  sl.registerLazySingleton(() => AddSubTaskUsecase());
  sl.registerLazySingleton(() => DeleteSubTaskUsecase());
  sl.registerLazySingleton(() => UpdateSubTaskUsecase());
  sl.registerLazySingleton(() => GetSubTasksUsecase());
  // Cubits
  sl.registerFactory(() => ThemeCubit());
  sl.registerFactory(() => TaskCubit());
  sl.registerFactory(() => SubTaskCubit());
  sl.registerFactory(() => SubTaskTitleCubit());
  sl.registerFactory(() => TasksWSubtaskCubit());
}
