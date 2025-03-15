import 'package:alarm_tasker/features/tasks/domain/entities/sub_task_title.dart';

import '../models/subtask_title_model.dart';

class SubTaskTitleMapper {
  static SubTaskTitleEntity toEntity(SubTaskTitleModel model) {
    return SubTaskTitleEntity(
      id: model.id,
      title: model.title,
      taskId: model.taskId,
    );
  }

  static SubTaskTitleModel toModel(SubTaskTitleEntity entity) {
    return SubTaskTitleModel(
      id: entity.id,
      title: entity.title,
      taskId: entity.taskId,
    );
  }
}
