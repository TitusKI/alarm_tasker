import 'package:hive/hive.dart';

import '../models/task_model.dart';

class TaskLocalDataSource {
  final Box<Task> taskBox;
  TaskLocalDataSource(this.taskBox);
  Future<List<Task>> getTasks() async {
    return taskBox.values.toList();
  }

  Future<void> addTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  Future<void> deleteTask(String taskId) async {
    await taskBox.delete(taskId);
  }
}
