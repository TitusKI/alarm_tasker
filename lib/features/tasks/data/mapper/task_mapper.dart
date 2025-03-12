import 'package:alarm_tasker/features/tasks/domain/entities/task.dart';

import '../models/task_model.dart';
import 'subtask_mapper.dart';

class TaskMapper {
  static TaskEntity toEntity(Task model) {
    return TaskEntity(
      id: model.id,
      title: model.title,
      subTasks: model.subTasks.map(SubTaskMapper.toEntity).toList(),
    );
  }

  static Task toModel(TaskEntity entity) {
    return Task(
      id: entity.id,
      title: entity.title,
      subTasks: entity.subTasks.map(SubTaskMapper.toModel).toList(),
    );
  }
}
