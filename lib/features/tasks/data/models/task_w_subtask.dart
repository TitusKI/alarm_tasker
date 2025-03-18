class TaskWithSubTasks {
  final String id;
  final String title;
  final List<SubTaskTitleWithSubtasks> subTaskTitles;

  TaskWithSubTasks({
    required this.id,
    required this.title,
    required this.subTaskTitles,
  });
}

class SubTaskTitleWithSubtasks {
  final String id;
  final String title;
  final List<SubTask> subtasks;

  SubTaskTitleWithSubtasks({
    required this.id,
    required this.title,
    required this.subtasks,
  });
}

class SubTask {
  final String id;
  final String title;
  final String? dueDate;
  final String? priority;
  final String? imagePath;
  final String? description;
  final bool isCompleted;

  SubTask({
    required this.id,
    required this.title,
    this.dueDate,
    this.priority,
    this.imagePath,
    this.description,
    required this.isCompleted,
  });

  factory SubTask.fromMap(Map<String, dynamic> map) {
    return SubTask(
      id: map['subTaskId'],
      title: map['subTaskName'],
      dueDate: map['dueDate'],
      priority: map['priority'],
      imagePath: map['imagePath'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
  // copyWith Method for updating subTask
  SubTask copyWith({
    String? id,
    String? title,
    String? dueDate,
    String? priority,
    String? imagePath,
    String? description,
    bool? isCompleted,
  }) {
    return SubTask(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
