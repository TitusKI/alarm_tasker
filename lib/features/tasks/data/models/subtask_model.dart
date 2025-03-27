class SubTaskModel {
  final String id;
  final String? title;
  final DateTime? dueDate;
  final String? priority;
  final String? imagePath;
  final String? description;
  final bool isCompleted;
  final DateTime? completedAt;
  final String subTaskTitleId; // Foreign key to SubTaskTitle

  SubTaskModel({
    required this.id,
    this.title,
    this.dueDate,
    this.priority,
    this.imagePath,
    this.description,
    this.isCompleted = false,
    this.completedAt,
    required this.subTaskTitleId,
  });

  // Convert to Map (only non-null values)
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    if (id.isNotEmpty) map['id'] = id; // Always include id if not empty
    if (title != null) map['title'] = title;
    if (dueDate != null) map['dueDate'] = dueDate!.toIso8601String();
    if (priority != null) map['priority'] = priority;
    if (imagePath != null) map['imagePath'] = imagePath;
    if (description != null) map['description'] = description;
    map['isCompleted'] = isCompleted ? 1 : 0; // Always include this field
    if (completedAt != null)
      map['completedAt'] = completedAt!.toIso8601String();
    if (subTaskTitleId.isNotEmpty)
      map['subTaskTitleId'] = subTaskTitleId; // Always include if not empty

    return map;
  }

  // Convert to Patch Map (only non-null values)
  Map<String, dynamic> toPatchMap() {
    final map = <String, dynamic>{};

    // if (title != null) map['title'] = title;
    // if (dueDate != null) map['dueDate'] = dueDate!.toIso8601String();
    // if (priority != null) map['priority'] = priority;
    // if (imagePath != null) map['imagePath'] = imagePath;
    // if (description != null) map['description'] = description;
    map['isCompleted'] = isCompleted ? 1 : 0; // Always include this field
    // map['subTaskTitleId'] = subTaskTitleId;
    // map['id'] = id;
    // Always include this field

    return map;
  }

  // Convert from Map
  factory SubTaskModel.fromMap(Map<String, dynamic> map) {
    return SubTaskModel(
      id: map['id'],
      title: map['title'],
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      priority: map['priority'],
      imagePath: map['imagePath'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      subTaskTitleId: map['subTaskTitleId'],
      completedAt: map['completedAt'],
    );
  }
}
