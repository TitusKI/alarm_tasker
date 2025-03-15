import 'package:sqflite/sqlite_api.dart';

import '../../../../injection_container.dart';
import '../mapper/result_mapper.dart';
import '../models/task_w_subtask.dart';

Future<TaskWithSubTasks> getTaskWithSubTasksById(String? taskId) async {
  final db = sl<Database>().database;

  final result = await db.rawQuery('''
    SELECT 
      t.id AS taskId, t.title AS taskTitle,
      st.id AS subTaskTitleId, st.title AS subTaskTitle,
      s.id AS subTaskId, s.title AS subTaskName, s.dueDate, s.priority, s.imagePath, s.description, s.isCompleted
    FROM tasks t
    LEFT JOIN subtask_titles st ON t.id = st.taskId
    LEFT JOIN subtasks s ON st.id = s.subTaskTitleId
    WHERE t.id = ?
    ORDER BY t.id, st.id, s.id
  ''', [taskId]);

  final tasksWithSubtasks = mapResultToModel(result);

  return tasksWithSubtasks.isNotEmpty
      ? tasksWithSubtasks.first
      : TaskWithSubTasks(id: '', title: '', subTaskTitles: []);
}
