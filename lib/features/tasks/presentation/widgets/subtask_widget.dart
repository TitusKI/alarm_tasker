import 'dart:async';

import 'package:alarm_tasker/core/util/date_completion.dart';
import 'package:alarm_tasker/features/theme/data/datasources/theme_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/sub_task.dart';

class SubTaskWidget extends StatelessWidget {
  final SubTaskEntity subTask;
  final Function(SubTaskEntity) onDelete;
  final Function(SubTaskEntity) onComplete;
  final StreamController<SubTaskEntity> subTaskStreamController;

  const SubTaskWidget({
    super.key,
    required this.subTask,
    required this.onDelete,
    required this.onComplete,
    required this.subTaskStreamController,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(subTask.id.toString()),
      direction: DismissDirection.horizontal,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        onDelete(subTask);
      },
      child: StatefulBuilder(builder: (context, setState) {
        return Row(
          children: [
            Container(
              width: 6.w,
              height: 70.h,
              color: subTask.isCompleted
                  ? sl<ThemeLocalDataSource>()
                      .getPrimaryColor()!
                      .withAlpha((0.5 * 255).toInt())
                  : sl<ThemeLocalDataSource>().getPrimaryColor(),
            ),
            Expanded(
              child: ListTile(
                leading: GestureDetector(
                  onTap: () {
                    setState(() {
                      subTask.isCompleted = !subTask.isCompleted;
                      subTask.completedAt =
                          subTask.isCompleted ? DateTime.now() : null;
                    });
                    onComplete(subTask);
                    // subTaskStreamController.add(subTask); // Notify changes
                  },
                  child: Icon(
                    subTask.isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: subTask.isCompleted ? Colors.amber : Colors.grey,
                  ),
                ),
                title: Text(
                  subTask.title ?? "",
                  style: !subTask.isCompleted
                      ? const TextStyle(
                          fontWeight: FontWeight.normal,
                        )
                      : const TextStyle(
                          fontWeight: FontWeight.w200,
                          decoration: TextDecoration.lineThrough),
                ),
                subtitle: subTask.isCompleted
                    ? Text(
                        subTask.completedAt != null
                            ? formatCompletedDate(subTask.completedAt!)
                            : "Completed",
                        style:
                            const TextStyle(color: Colors.green, fontSize: 12),
                      )
                    : subTask.dueDate != null ||
                            subTask.priority != null ||
                            subTask.description != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (subTask.dueDate != null)
                                Text(
                                  "${subTask.dueDate!.day}/${subTask.dueDate!.month}/${subTask.dueDate!.year} ${subTask.dueDate!.hour > 12 ? subTask.dueDate!.hour - 12 : subTask.dueDate!.hour}:${subTask.dueDate!.minute.toString().padLeft(2, '0')} ${subTask.dueDate!.hour >= 12 ? 'PM' : 'AM'}",
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              if (subTask.description != null)
                                Text("${subTask.description}",
                                    style:
                                        Theme.of(context).textTheme.labelSmall),
                              if (subTask.priority != null)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Tags",
                                    style: TextStyle(
                                        color: Colors.blue.shade800,
                                        fontSize: 12),
                                  ),
                                ),
                            ],
                          )
                        : null,
                trailing: subTask.imagePath != null
                    ? const Icon(Icons.camera_alt, color: Colors.grey)
                    : null,
              ),
            ),
          ],
        );
      }),
    );
  }
}
