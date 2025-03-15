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
  final String dueDate;
  final String priority;
  final String? imagePath;
  final String? description;
  final bool isCompleted;

  SubTask({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.priority,
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
}
