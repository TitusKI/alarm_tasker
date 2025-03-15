import 'package:bloc/bloc.dart';

import '../../../../core/resources/generic_state.dart';
import '../../../../injection_container.dart';
import '../../data/datasources/get_all_data.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/task_usecase.dart';

class TaskCubit extends Cubit<GenericState<List<TaskEntity>>> {
  TaskCubit() : super(GenericState.initial());

  Future<void> loadTasks() async {
    emit(GenericState.loading());
    try {
      final tasks = await sl<GetTasksUsecase>().call();
      emit(GenericState.success(tasks));
    } catch (e) {
      emit(GenericState.failure(e.toString()));
    }
  }

  Future<void> addTask(TaskEntity task) async {
    try {
      await sl<AddTaskUsecase>().call(params: task);
      final updatedList = List<TaskEntity>.from(state.data ?? [])..add(task);
      emit(GenericState.success(updatedList));
    } catch (e) {
      emit(GenericState.failure(e.toString()));
    }
  }

  Future<void> updateTask(TaskEntity task) async {
    try {
      await sl<UpdateTaskUsecase>().call(params: task);
      final updatedList = (state.data ?? []).map((task) {
        return task.id == task.id ? task : task;
      }).toList();
      emit(GenericState.success(updatedList));
    } catch (e) {
      emit(GenericState.failure(e.toString()));
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await sl<DeleteTaskUsecase>().call(params: taskId);
      final updatedList =
          (state.data ?? []).where((task) => task.id != taskId).toList();
      emit(GenericState.success(updatedList));
    } catch (e) {
      emit(GenericState.failure(e.toString()));
    }
  }
}
