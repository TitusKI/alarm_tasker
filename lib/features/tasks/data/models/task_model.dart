class TaskModel {
  final String id;
  final String title;

  TaskModel({
    required this.id,
    required this.title,
  });

  // Convert a TaskModel to a Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  // Convert a Map to a TaskModel (from SQLite)
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
    );
  }
}
