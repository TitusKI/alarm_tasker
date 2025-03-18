import 'package:alarm_tasker/features/tasks/domain/usecases/subtask_usecase.dart';
import 'package:bloc/bloc.dart';

import '../../../../core/resources/generic_state.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/sub_task.dart';

class SubTaskCubit extends Cubit<GenericState<List<SubTaskEntity>>> {
  SubTaskCubit() : super(GenericState.initial());

  Future<void> loadSubTasks(String subTaskId) async {
    emit(GenericState.loading());
    try {
      final subTasks = await sl<GetSubTasksUsecase>().call(params: subTaskId);
      emit(GenericState.success(subTasks));
    } catch (e) {
      emit(GenericState.failure(e.toString()));
    }
  }

  Future<void> addSubTask(SubTaskEntity subTask) async {
    try {
      print("Adding subtask....");
      await sl<AddSubTaskUsecase>().call(params: subTask);
      print("successfully added subtask");
      // Get the existing subtasks for the specific SubTaskTitle
      final updatedList = List<SubTaskEntity>.from(state.data ?? [])
          .where((s) => s.subTaskTitleId != subTask.subTaskTitleId)
          .toList();

      updatedList.add(subTask);

      print("updatedList: $updatedList");
      emit(GenericState.success(updatedList));
    } catch (e) {
      print("Error catched: $e");
      emit(GenericState.failure(e.toString()));
    }
  }

  Future<void> updateSubTask(SubTaskEntity subTask) async {
    try {
      await sl<UpdateSubTaskUsecase>().call(params: subTask);
      final updatedList = (state.data ?? []).map((task) {
        return task.id == subTask.id ? subTask : task;
      }).toList();
      emit(GenericState.success(updatedList));
    } catch (e) {
      emit(GenericState.failure(e.toString()));
    }
  }

  Future<void> deleteSubTask(String subTaskId) async {
    try {
      await sl<DeleteSubTaskUsecase>().call(params: subTaskId);
      final updatedList =
          (state.data ?? []).where((task) => task.id != subTaskId).toList();
      emit(GenericState.success(updatedList));
    } catch (e) {
      emit(GenericState.failure(e.toString()));
    }
  }
}
