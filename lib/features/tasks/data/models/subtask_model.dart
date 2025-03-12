import 'package:hive/hive.dart';

part 'subtask_model.g.dart'; // Generated file

@HiveType(typeId: 1)
class SubTask {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isCompleted;

  SubTask({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}
