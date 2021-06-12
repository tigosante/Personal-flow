import 'package:personal_flow/domain/task/task.args.dart';
import 'package:personal_flow/domain/task/task.entity.dart';
import 'package:personal_flow/domain/task/task.repository.interface.dart';

class TaskRepository implements TaskRepositoryInterface {
  @override
  Future<TaskEntity> delete(TaskDeleteArgs args) async {
    return TaskEntity();
  }

  @override
  Future<TaskEntity> find(TaskFindArgs args) async {
    return TaskEntity();
  }

  @override
  Future<TaskEntity> findAll(TaskFindAllArgs args) async {
    return TaskEntity();
  }

  @override
  Future<TaskEntity> save(TaskSaveArgs args) async {
    return TaskEntity();
  }

  @override
  Future<TaskEntity> update(TaskUpdateArgs args) async {
    return TaskEntity();
  }
}
