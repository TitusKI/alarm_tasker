import 'package:alarm_tasker/features/tasks/data/models/subtask_model.dart';
import 'package:sqflite/sqflite.dart';

class SubTaskLocalDataSource {
  final Database database;

  SubTaskLocalDataSource(this.database);

  Future<List<SubTaskModel>> getSubTasks(String subTaskTitleId) async {
    print("Starting subtasks");
    final maps = await database.query(
      'subtasks',
      where: 'subTaskTitleId = ?',
      whereArgs: [subTaskTitleId],
    );
    print("subTasks: $maps");
    final List<SubTaskModel> fetchedSubtasks =
        maps.map((map) => SubTaskModel.fromMap(map)).toList();
    print("fetchedSubtasks: $fetchedSubtasks");
    return fetchedSubtasks;
  }

  Future<void> addSubTask(SubTaskModel subTask) async {
    print("Adding subtask");
    await database.insert('subtasks', subTask.toMap());
    print("Successfully added subtask");
  }

  Future<void> updateSubTask(SubTaskModel subTask) async {
    await database.update(
      'subtasks',
      subTask.toMap(),
      where: 'id = ?',
      whereArgs: [subTask.id],
    );
  }

  Future<void> deleteSubTask(String subTaskId) async {
    await database.delete(
      'subtasks',
      where: 'id = ?',
      whereArgs: [subTaskId],
    );
  }
}
