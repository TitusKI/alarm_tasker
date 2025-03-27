import 'package:alarm_tasker/features/tasks/data/models/subtask_model.dart';

import '../models/task_w_subtask.dart';

List<TaskWithSubTasks> mapResultToModel(List<Map<String, dynamic>> result) {
  final Map<String, TaskWithSubTasks> taskMap = {};

  for (var row in result) {
    final taskId = row['taskId'] as String;
    final taskTitle = row['taskTitle'] as String;

    // Initialize Task if not present
    if (!taskMap.containsKey(taskId)) {
      taskMap[taskId] = TaskWithSubTasks(
        id: taskId,
        title: taskTitle,
        subTaskTitles: [],
      );
    }

    final task = taskMap[taskId]!;

    // Handle SubTaskTitle
    final subTaskTitleId = row['subTaskTitleId'] as String?;
    if (subTaskTitleId != null) {
      var subTaskTitle = task.subTaskTitles.firstWhere(
        (st) => st.id == subTaskTitleId,
        orElse: () {
          final newSubTaskTitle = SubTaskTitleWithSubtasks(
            id: subTaskTitleId,
            title: row['subTaskTitle'] as String,
            subtasks: [],
          );
          task.subTaskTitles.add(newSubTaskTitle);
          return newSubTaskTitle;
        },
      );

      // Handle SubTask
      final subTaskId = row['subTaskId'] as String?;
      if (subTaskId != null) {
        final subTask = SubTaskModel(
          id: subTaskId,
          title: row['subTaskName'] as String,
          dueDate: row['dueDate'] != null
              ? DateTime.tryParse(row['dueDate'] as String)
              : null,
          completedAt: row['completedAt'] != null
              ? DateTime.tryParse(row['completedAt'])
              : null,
          priority: row['priority'] as String?,
          imagePath: row['imagePath'] as String?,
          description: row['description'] as String?,
          isCompleted: (row['isCompleted'] as int) == 1,
          subTaskTitleId: row['subTaskTitleId'] as String,
        );

        subTaskTitle.subtasks.add(subTask);
      }
    }
  }

  return taskMap.values.toList();
}
