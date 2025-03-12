import 'package:alarm_tasker/core/usecase/usecase.dart';

import '../../../../injection_container.dart';
import '../repositories/task_repository.dart';

class DeleteTaskUsecase implements Usecase<void, String> {
  @override
  Future<void> call({String? params}) {
    return sl<TaskRepository>().deleteTask(params!);
  }
}
