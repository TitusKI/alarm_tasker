import 'sub_task_title.dart';

class TaskEntity {
  final String id;
  final String title;
  final List<SubTaskTitleEntity> subTaskTitles;

  TaskEntity({
    required this.id,
    required this.title,
    this.subTaskTitles = const [],
  });
}
