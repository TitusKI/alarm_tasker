import 'sub_task.dart';

class TaskEntity {
  final String id;
  final String title;
  final List<SubTaskEntity> subTasks;

  TaskEntity({
    required this.id,
    required this.title,
    this.subTasks = const [],
  });
}
