import 'package:alarm_tasker/features/tasks/data/models/task_w_subtask.dart';
import 'package:alarm_tasker/features/tasks/domain/entities/sub_task.dart';
import 'package:alarm_tasker/features/tasks/presentation/cubit/subtasks_cubit.dart';
import 'package:alarm_tasker/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:alarm_tasker/features/tasks/presentation/pages/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../injection_container.dart';
import '../../../theme/presentation/cubit/theme_cubit.dart';
import '../../data/datasources/db_constant.dart';
import '../cubit/tasks_w_subtask_cubit.dart';

class QuickAddBar extends StatelessWidget {
  final TabController tabController;

  const QuickAddBar({required this.tabController, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController addTaskController = TextEditingController();
    final id = UniqueKey().toString();
    final theme = context.read<ThemeCubit>().state;
    final textTheme = Theme.of(context).textTheme;
    final taskId = sl<ConstantLocalDataSource>().getTaskId();

    // Get the current task and its subTaskTitles
    final task = context.watch<TasksWSubtaskCubit>().state.data;

    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: theme.primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: addTaskController,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: 'Quick add task...',
                  hintStyle: textTheme.labelMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0.r),
                  ),
                ),
                style: textTheme.labelLarge,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward, color: theme.textColor),
              onPressed: () {
                // Ensure valid index and get subTaskTitleId
                if (task != null &&
                    tabController.index >= 0 &&
                    tabController.index < task.subTaskTitles.length) {
                  final subTaskTitleId =
                      task.subTaskTitles[tabController.index].id;
                  print("subTaskTitleId: $subTaskTitleId");
                  // Add the subtask with the current tab's subTaskTitleId
                  final newSubTask = SubTaskEntity(
                    id: id,
                    title: addTaskController.text,
                    subTaskTitleId: subTaskTitleId,
                  );
                  if (context.mounted) {
                    context
                        .read<SubTaskCubit>()
                        .addSubTask(newSubTask)
                        .then((_) => {
                              context
                                  .read<TasksWSubtaskCubit>()
                                  .loadTasksWithSubTasks(id: taskId)
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => Tasks()))
                            });
                    addTaskController.clear(); // Clear input after adding
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
