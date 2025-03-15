import 'package:alarm_tasker/features/tasks/domain/entities/sub_task.dart';

abstract class SubTaskRepository {
  Future<List<SubTaskEntity>> getSubTasks(String subTaskTitleId);
  Future<void> addSubTask(SubTaskEntity task);
  Future<void> updateSubTask(SubTaskEntity task);
  Future<void> deleteSubTask(String taskId);
}
