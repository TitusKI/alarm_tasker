import 'package:sqflite/sqflite.dart';
import '../models/task_model.dart';

class TaskLocalDataSource {
  final Database database;
  TaskLocalDataSource(this.database);
  // debugging
  Future<List<TaskModel>> getTasks() async {
    print('Started to get task');
    final tasks = await database.query('tasks');
    print("tasks: $tasks");
    final List<TaskModel> fetchedTask =
        tasks.map((e) => TaskModel.fromMap(e)).toList();
    print("fetchedTask: $fetchedTask");
    return fetchedTask;
  }

  Future<void> addTask(TaskModel task) async {
    print("added task: ${task.toMap()}");
    await database.insert('tasks', task.toMap());
  }

  Future<void> updateTask(TaskModel task) async {
    await database
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(String taskId) async {
    await database.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
  }
}
