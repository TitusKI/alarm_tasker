import 'package:bloc/bloc.dart';

import '../../../../core/resources/generic_state.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/sub_task_title.dart';
import '../../domain/usecases/subtask_title_usecase.dart';

class SubTaskTitleCubit extends Cubit<GenericState<List<SubTaskTitleEntity>>> {
  SubTaskTitleCubit() : super(GenericState.initial());

  Future<void> loadSubTaskTitles(String taskId) async {
    emit(GenericState.loading());
    try {
      final subTaskTitles =
          await sl<GetSubTasksTitleUsecase>().call(params: taskId);
      emit(GenericState.success(subTaskTitles));
    } catch (e) {
      emit(GenericState.failure(e.toString()));
    }
  }

  Future<void> addSubTaskTitle(SubTaskTitleEntity subTaskTitle) async {
    try {
      print("Starting to add subtask title");
      await sl<AddSubTaskTitleUsecase>().call(params: subTaskTitle);
      final updatedList = List<SubTaskTitleEntity>.from(state.data ?? [])
        ..add(subTaskTitle);
      emit(GenericState.success(updatedList));
    } catch (e) {
      print(" Error...adding subtask title: $e");
      emit(GenericState.failure(e.toString()));
    }
  }

  Future<void> updateSubTaskTitle(SubTaskTitleEntity subTaskTitle) async {
    try {
      await sl<UpdateSubTaskTitleUsecase>().call(params: subTaskTitle);
      final updatedList = (state.data ?? []).map((task) {
        return task.id == subTaskTitle.id ? subTaskTitle : task;
      }).toList();
      emit(GenericState.success(updatedList));
    } catch (e) {
      emit(GenericState.failure(e.toString()));
    }
  }

  Future<void> deleteSubTaskTitle(String subTaskTitleId) async {
    try {
      await sl<DeleteSubTaskTitleUsecase>().call(params: subTaskTitleId);
      final updatedList = (state.data ?? [])
          .where((task) => task.id != subTaskTitleId)
          .toList();
      emit(GenericState.success(updatedList));
    } catch (e) {
      emit(GenericState.failure(e.toString()));
    }
  }
}
