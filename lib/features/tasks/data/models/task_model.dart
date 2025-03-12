import 'package:hive/hive.dart';

import 'subtask_model.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<SubTask> subTasks;

  Task({
    required this.id,
    required this.title,
    this.subTasks = const [],
  });
}
