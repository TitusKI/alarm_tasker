import 'package:alarm_tasker/core/usecase/usecase.dart';

import '../../../../injection_container.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class UpdateTaskUsecase implements Usecase<void, TaskEntity> {
  @override
  Future<void> call({TaskEntity? params}) {
    return sl<TaskRepository>().updateTask(params!);
  }
}
