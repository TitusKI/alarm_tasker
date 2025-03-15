import 'package:alarm_tasker/features/tasks/domain/entities/sub_task.dart';

import '../models/subtask_model.dart';

class SubTaskMapper {
  static SubTaskEntity toEntity(SubTaskModel model) {
    return SubTaskEntity(
      id: model.id,
      title: model.title,
      dueDate: model.dueDate,
      priority: model.priority,
      imagePath: model.imagePath,
      description: model.description,
      isCompleted: model.isCompleted,
      subTaskTitleId: model.subTaskTitleId,
    );
  }

  static SubTaskModel toModel(SubTaskEntity entity) {
    return SubTaskModel(
      id: entity.id,
      title: entity.title,
      dueDate: entity.dueDate,
      priority: entity.priority,
      imagePath: entity.imagePath,
      description: entity.description,
      isCompleted: entity.isCompleted,
      subTaskTitleId: entity.subTaskTitleId,
    );
  }
}
