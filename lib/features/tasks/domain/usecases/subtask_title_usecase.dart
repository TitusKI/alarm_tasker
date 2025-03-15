import 'package:alarm_tasker/core/usecase/usecase.dart';

import '../../../../injection_container.dart';
import '../entities/sub_task_title.dart';
import '../repositories/subtask_title_repo.dart';

class AddSubTaskTitleUsecase implements Usecase<void, SubTaskTitleEntity> {
  @override
  Future<void> call({SubTaskTitleEntity? params}) {
    return sl<SubTaskTitleRepository>().addSubTaskTitle(params!);
  }
}

class DeleteSubTaskTitleUsecase implements Usecase<void, String> {
  @override
  Future<void> call({String? params}) {
    return sl<SubTaskTitleRepository>().deleteSubTaskTitle(params!);
  }
}

class UpdateSubTaskTitleUsecase implements Usecase<void, SubTaskTitleEntity> {
  @override
  Future<void> call({SubTaskTitleEntity? params}) {
    return sl<SubTaskTitleRepository>().updateSubTaskTitle(params!);
  }
}

class GetSubTasksTitleUsecase
    implements Usecase<List<SubTaskTitleEntity>, String> {
  @override
  Future<List<SubTaskTitleEntity>> call({String? params}) {
    return sl<SubTaskTitleRepository>().getSubTaskTitles(params!);
  }
}
