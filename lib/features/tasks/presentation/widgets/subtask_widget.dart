import 'package:alarm_tasker/features/theme/data/datasources/theme_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../injection_container.dart';
import '../../data/models/task_w_subtask.dart';

class SubTaskWidget extends StatelessWidget {
  final SubTask subTask;
  final Function(SubTask) onDelete;
  final Function(SubTask) onComplete;

  const SubTaskWidget(
      {super.key,
      required this.subTask,
      required this.onDelete,
      required this.onComplete});

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
        child: Row(
          children: [
            Container(
              width: 6.w,
              height: 70.h,
              color: sl<ThemeLocalDataSource>()
                  .getPrimaryColor(), // Vertical bar color
            ),
            Expanded(
              child: ListTile(
                leading: GestureDetector(
                  onTap: () => onComplete(subTask),
                  child: Icon(
                    subTask.isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: subTask.isCompleted ? Colors.green : Colors.grey,
                  ),
                ),
                title: Text(subTask.title,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (subTask.dueDate != null)
                      Text(
                        subTask.dueDate!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
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
                              color: Colors.blue.shade800, fontSize: 12),
                        ),
                      ),
                  ],
                ),
                trailing: subTask.imagePath != null
                    ? const Icon(Icons.camera_alt, color: Colors.grey)
                    : null,
              ),
            ),
          ],
        ));
  }
}
