import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../../theme/presentation/cubit/theme_cubit.dart';
import '../../data/datasources/db_constant.dart';
import '../../domain/entities/sub_task_title.dart';
import '../cubit/subtask_titles_cubit.dart';
import '../cubit/tasks_w_subtask_cubit.dart';

class SubListAddDialog extends StatefulWidget {
  const SubListAddDialog({super.key});

  @override
  State<SubListAddDialog> createState() => _SubListAddDialogState();
}

class _SubListAddDialogState extends State<SubListAddDialog> {
  final TextEditingController _subListTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeCubit>().state;
    final textTheme = Theme.of(context).textTheme;
    final taskId = sl<ConstantLocalDataSource>().getTaskId();
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              color: theme.primaryColor,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sub List Name', style: textTheme.titleLarge),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: _subListTitleController,
                    decoration: InputDecoration(
                      hintText: "Let's give it a name...",
                      hintStyle: textTheme.labelMedium,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0.h),
                    child: Text(
                      'Where should completed tasks go?',
                      style: textTheme.titleLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.format_list_bulleted,
                      color: theme.primaryColor,
                    ),
                    title: Text(
                      'This list',
                    ),
                    trailing: Icon(Icons.arrow_drop_down),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.h,
                      vertical: 8.0.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0.h),
                        TextButton(
                          onPressed: () {
                            final subTaskTitleId = UniqueKey().toString();

                            context
                                .read<SubTaskTitleCubit>()
                                .addSubTaskTitle(
                                  SubTaskTitleEntity(
                                    title: _subListTitleController.text,
                                    taskId: taskId!,
                                    id: subTaskTitleId,
                                  ),
                                )
                                .then((_) {
                              if (mounted) {
                                Navigator.of(context).pop();
                                context.go("/tasks");
                                context
                                    .read<TasksWSubtaskCubit>()
                                    .loadTasksWithSubTasks(id: taskId);
                              }
                            });
                          },
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSubListAddDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SubListAddDialog();
    },
  );
}
