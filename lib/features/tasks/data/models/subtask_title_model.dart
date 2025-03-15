class SubTaskTitleModel {
  final String id;
  final String title;
  final String taskId; // Foreign key to Task

  SubTaskTitleModel({
    required this.id,
    required this.title,
    required this.taskId,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'taskId': taskId,
    };
  }

  // Convert from Map
  factory SubTaskTitleModel.fromMap(Map<String, dynamic> map) {
    return SubTaskTitleModel(
      id: map['id'],
      title: map['title'],
      taskId: map['taskId'],
    );
  }
}
