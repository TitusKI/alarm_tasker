class SubTaskModel {
  final String id;
  final String title;
  final DateTime? dueDate;
  final String? priority;
  final String? imagePath;
  final String? description;
  final bool isCompleted;
  final String subTaskTitleId; // Foreign key to SubTaskTitle

  SubTaskModel({
    required this.id,
    required this.title,
    this.dueDate,
    this.priority,
    this.imagePath,
    this.description,
    this.isCompleted = false,
    required this.subTaskTitleId,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'dueDate': dueDate?.toIso8601String(),
      'priority': priority,
      'imagePath': imagePath,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'subTaskTitleId': subTaskTitleId,
    };
  }

  // Convert from Map
  factory SubTaskModel.fromMap(Map<String, dynamic> map) {
    return SubTaskModel(
      id: map['id'],
      title: map['title'],
      dueDate: DateTime.parse(map['dueDate']),
      priority: map['priority'],
      imagePath: map['imagePath'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      subTaskTitleId: map['subTaskTitleId'],
    );
  }
}
