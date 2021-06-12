import 'package:personal_flow/domain/task/task.args.dart'
    show
        TaskFindArgs,
        TaskFindAllArgs,
        TaskSaveArgs,
        TaskUpdateArgs,
        TaskDeleteArgs;
import 'package:personal_flow/domain/task/task.entity.dart';
import 'package:personal_flow/domain/task/task.repository.interface.dart';

class TaskService {
  TaskService(this._repository);
  final TaskRepositoryInterface _repository;

  Future<TaskEntity> find(TaskFindArgs args) async {
    return TaskEntity();
  }

  Future<TaskEntity> findAll(TaskFindAllArgs args) async {
    return TaskEntity();
  }

  Future<TaskEntity> save(TaskSaveArgs args) async {
    return TaskEntity();
  }

  Future<TaskEntity> update(TaskUpdateArgs args) async {
    return TaskEntity();
  }

  Future<TaskEntity> delete(TaskDeleteArgs args) async {
    return TaskEntity();
  }
}
