class SubTaskEntity {
  final String id;
  final String title;
  final DateTime? dueDate;
  final String? priority;
  final String? imagePath;
  final String? description;
  final bool isCompleted;
  final String subTaskTitleId;

  SubTaskEntity({
    required this.id,
    required this.title,
    this.dueDate,
    this.isCompleted = false,
    this.priority,
    this.imagePath,
    this.description,
    required this.subTaskTitleId,
  });
}
