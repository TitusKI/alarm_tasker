import 'package:alarm_tasker/features/tasks/domain/entities/task.dart';

import '../models/task_model.dart';

class TaskMapper {
  static TaskEntity toEntity(TaskModel model) {
    return TaskEntity(
      id: model.id,
      title: model.title,
    );
  }

  static TaskModel toModel(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
    );
  }
}
