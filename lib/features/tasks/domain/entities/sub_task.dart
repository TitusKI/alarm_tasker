class SubTaskEntity {
  final String id;
  final String title;
  final bool isCompleted;

  SubTaskEntity({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}
