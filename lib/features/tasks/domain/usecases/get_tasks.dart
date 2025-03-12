import 'package:alarm_tasker/core/usecase/usecase.dart';

import '../../../../injection_container.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetTasksUsecase implements Usecase<List<TaskEntity>, void> {
  @override
  Future<List<TaskEntity>> call({void params}) {
    return sl<TaskRepository>().getTasks();
  }
}
