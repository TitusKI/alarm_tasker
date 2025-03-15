import 'package:alarm_tasker/features/tasks/data/mapper/subtask_mapper.dart';
import 'package:alarm_tasker/features/tasks/domain/repositories/subtask_repository.dart';

import '../../domain/entities/sub_task.dart';
import '../datasources/sub_task_local_data_source.dart';
import '../../../../injection_container.dart';
import '../models/subtask_model.dart';

class SubTaskRepositoryImpl implements SubTaskRepository {
  @override
  Future<List<SubTaskEntity>> getSubTasks(String subTaskTitleId) async {
    final List<SubTaskModel> subTaskModel =
        await sl<SubTaskLocalDataSource>().getSubTasks(subTaskTitleId);
    return subTaskModel.map((e) => SubTaskMapper.toEntity(e)).toList();
  }

  @override
  Future<void> addSubTask(SubTaskEntity task) async {
    final SubTaskModel subTaskModel = SubTaskMapper.toModel(task);
    await sl.call<SubTaskLocalDataSource>().addSubTask(subTaskModel);
  }

  @override
  Future<void> updateSubTask(SubTaskEntity task) async {
    final SubTaskModel subTaskModel = SubTaskMapper.toModel(task);

    await sl.call<SubTaskLocalDataSource>().updateSubTask(subTaskModel);
  }

  @override
  Future<void> deleteSubTask(String taskId) async {
    await sl.call<SubTaskLocalDataSource>().deleteSubTask(taskId);
  }
}
