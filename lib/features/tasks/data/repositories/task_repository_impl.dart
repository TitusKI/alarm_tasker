import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../../../../injection_container.dart';
import '../mapper/task_mapper.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  @override
  Future<List<TaskEntity>> getTasks() async {
    final taskModel = await sl<TaskLocalDataSource>().getTasks();
    return taskModel.map((e) => TaskMapper.toEntity(e)).toList();
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    final Task taskModel = TaskMapper.toModel(task);
    await sl.call<TaskLocalDataSource>().addTask(taskModel);
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final Task taskModel = TaskMapper.toModel(task);

    await sl.call<TaskLocalDataSource>().updateTask(taskModel);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await sl.call<TaskLocalDataSource>().deleteTask(taskId);
  }
}
