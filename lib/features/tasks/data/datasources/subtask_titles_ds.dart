import 'package:alarm_tasker/features/tasks/data/models/subtask_title_model.dart';
import 'package:sqflite/sqflite.dart';

class SubTaskTitlesDataSource {
  final Database database;
  SubTaskTitlesDataSource(this.database);
  Future<List<SubTaskTitleModel>> getSubTaskTitles(String taskId) async {
    print("Starting subtask titles....");
    final subTaskTitles = await database
        .query('subtask_titles', where: 'taskId= ?', whereArgs: [taskId]);
    print("subTaskTitles: $subTaskTitles");
    final List<SubTaskTitleModel> fetchedTitle =
        subTaskTitles.map((e) => SubTaskTitleModel.fromMap(e)).toList();
    print("fetchedTitle: $fetchedTitle");
    return fetchedTitle;
  }

  Future<void> addSubTaskTitle(SubTaskTitleModel subTaskTitle) async {
    print("Adding subtasktitle..........");
    await database.insert('subtask_titles', subTaskTitle.toMap());
    print("Successfully added subtasktitle");
  }

  Future<void> updateSubTaskTitle(SubTaskTitleModel subTaskTitle) async {
    await database.update('subtask_titles', subTaskTitle.toMap(),
        where: 'id = ?', whereArgs: [subTaskTitle.id]);
  }

  Future<void> deleteSubTaskTitle(String subTaskTitleId) async {
    await database
        .delete('subtask_titles', where: 'id = ?', whereArgs: [subTaskTitleId]);
  }
}
