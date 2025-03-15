import 'package:alarm_tasker/core/usecase/usecase.dart';

import '../../../../injection_container.dart';
import '../entities/sub_task.dart';
import '../repositories/subtask_repository.dart';

class AddSubTaskUsecase implements Usecase<void, SubTaskEntity> {
  @override
  Future<void> call({SubTaskEntity? params}) {
    return sl<SubTaskRepository>().addSubTask(params!);
  }
}

class DeleteSubTaskUsecase implements Usecase<void, String> {
  @override
  Future<void> call({String? params}) {
    return sl<SubTaskRepository>().deleteSubTask(params!);
  }
}

class UpdateSubTaskUsecase implements Usecase<void, SubTaskEntity> {
  @override
  Future<void> call({SubTaskEntity? params}) {
    return sl<SubTaskRepository>().updateSubTask(params!);
  }
}

class GetSubTasksUsecase implements Usecase<List<SubTaskEntity>, String> {
  @override
  Future<List<SubTaskEntity>> call({String? params}) {
    return sl<SubTaskRepository>().getSubTasks(params!);
  }
}
