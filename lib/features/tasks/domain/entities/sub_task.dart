class SubTaskEntity {
  final String id;
  final String? title;
  final DateTime? dueDate;
  final String? priority;
  final String? imagePath;
  final String? description;
  bool isCompleted;
  DateTime? completedAt;
  final String subTaskTitleId;

  SubTaskEntity({
    required this.id,
    this.title,
    this.dueDate,
    this.isCompleted = false,
    this.priority,
    this.imagePath,
    this.description,
    this.completedAt,
    required this.subTaskTitleId,
  });
}
