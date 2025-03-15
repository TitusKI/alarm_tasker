import '../entities/sub_task_title.dart';

abstract class SubTaskTitleRepository {
  Future<List<SubTaskTitleEntity>> getSubTaskTitles(String taskId);
  Future<void> addSubTaskTitle(SubTaskTitleEntity task);
  Future<void> updateSubTaskTitle(SubTaskTitleEntity task);
  Future<void> deleteSubTaskTitle(String taskId);
}
