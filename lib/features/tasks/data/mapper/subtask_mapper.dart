import 'package:alarm_tasker/features/tasks/domain/entities/sub_task.dart';

import '../models/subtask_model.dart';

class SubTaskMapper {
  static SubTaskEntity toEntity(SubTask model) {
    return SubTaskEntity(
      id: model.id,
      title: model.title,
      isCompleted: model.isCompleted,
    );
  }

  static SubTask toModel(SubTaskEntity entity) {
    return SubTask(
      id: entity.id,
      title: entity.title,
      isCompleted: entity.isCompleted,
    );
  }
}
