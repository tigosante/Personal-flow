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
    return await _repository.find(args);
  }

  Future<TaskEntity> findAll(TaskFindAllArgs args) async {
    return await _repository.findAll(args);
  }

  Future<TaskEntity> save(TaskSaveArgs args) async {
    return await _repository.save(args);
  }

  Future<TaskEntity> update(TaskUpdateArgs args) async {
    return await _repository.update(args);
  }

  Future<TaskEntity> delete(TaskDeleteArgs args) async {
    return await _repository.delete(args);
  }
}
