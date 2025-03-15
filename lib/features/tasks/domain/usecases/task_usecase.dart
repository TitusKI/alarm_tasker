import 'package:alarm_tasker/core/usecase/usecase.dart';

import '../../../../injection_container.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class AddTaskUsecase implements Usecase<void, TaskEntity> {
  @override
  Future<void> call({TaskEntity? params}) {
    return sl<TaskRepository>().addTask(params!);
  }
}

class DeleteTaskUsecase implements Usecase<void, String> {
  @override
  Future<void> call({String? params}) {
    return sl<TaskRepository>().deleteTask(params!);
  }
}

class UpdateTaskUsecase implements Usecase<void, TaskEntity> {
  @override
  Future<void> call({TaskEntity? params}) {
    return sl<TaskRepository>().updateTask(params!);
  }
}

class GetTasksUsecase implements Usecase<List<TaskEntity>, void> {
  @override
  Future<List<TaskEntity>> call({void params}) {
    return sl<TaskRepository>().getTasks();
  }
}
