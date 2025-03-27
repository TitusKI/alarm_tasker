import 'package:alarm_tasker/features/tasks/data/models/task_w_subtask.dart';
import 'package:bloc/bloc.dart';

import '../../../../core/resources/generic_state.dart';
import '../../data/datasources/get_all_data.dart';

class TasksWSubtaskCubit extends Cubit<GenericState<TaskWithSubTasks>> {
  TasksWSubtaskCubit() : super(GenericState.initial());

  Future<void> loadTasksWithSubTasks({String? id}) async {
    emit(GenericState.loading());
    try {
      final tasks = await getTaskWithSubTasksById(id);
      print("Successfully fetched all da");
      emit(GenericState.success(tasks));
    } catch (e) {
      print("Error catched: $e");
      emit(GenericState.failure(e.toString()));
    }
  }
}
