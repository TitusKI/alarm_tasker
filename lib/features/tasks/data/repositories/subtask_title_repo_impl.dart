import 'package:alarm_tasker/features/tasks/data/datasources/subtask_titles_ds.dart';
import 'package:alarm_tasker/features/tasks/data/mapper/subtask_mapper.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/sub_task_title.dart';
import '../../domain/repositories/subtask_title_repo.dart';
import '../mapper/subtask_title_mapper.dart';
import '../models/subtask_title_model.dart';

class SubTaskTitleRepositoryImpl implements SubTaskTitleRepository {
  @override
  Future<List<SubTaskTitleEntity>> getSubTaskTitles(
      String subTaskTitleId) async {
    final List<SubTaskTitleModel> subTaskTitleModel =
        await sl<SubTaskTitlesDataSource>().getSubTaskTitles(subTaskTitleId);
    return subTaskTitleModel
        .map((e) => SubTaskTitleMapper.toEntity(e))
        .toList();
  }

  @override
  Future<void> addSubTaskTitle(SubTaskTitleEntity task) async {
    final SubTaskTitleModel subTaskTitleModel =
        SubTaskTitleMapper.toModel(task);
    await sl<SubTaskTitlesDataSource>().addSubTaskTitle(subTaskTitleModel);
  }

  @override
  Future<void> updateSubTaskTitle(SubTaskTitleEntity task) async {
    final SubTaskTitleModel subTaskTitleModel =
        SubTaskTitleMapper.toModel(task);

    await sl<SubTaskTitlesDataSource>().updateSubTaskTitle(subTaskTitleModel);
  }

  @override
  Future<void> deleteSubTaskTitle(String taskId) async {
    await sl<SubTaskTitlesDataSource>().deleteSubTaskTitle(taskId);
  }
}
