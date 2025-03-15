import 'package:alarm_tasker/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alarm_tasker/features/theme/presentation/cubit/theme_cubit.dart';

import '../../features/tasks/presentation/cubit/subtask_titles_cubit.dart';
import '../../features/tasks/presentation/cubit/subtasks_cubit.dart';
import '../../features/tasks/presentation/cubit/tasks_cubit.dart';
import '../../features/tasks/presentation/cubit/tasks_w_subtask_cubit.dart'
    show TasksWSubtaskCubit;

List<BlocProvider> getBlocProviders() {
  return [
    BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),
    BlocProvider<TaskCubit>(create: (_) => sl<TaskCubit>()),
    BlocProvider<SubTaskCubit>(create: (_) => sl<SubTaskCubit>()),
    BlocProvider<SubTaskTitleCubit>(create: (_) => sl<SubTaskTitleCubit>()),
    BlocProvider<TasksWSubtaskCubit>(create: (_) => sl<TasksWSubtaskCubit>()),
  ];
}
