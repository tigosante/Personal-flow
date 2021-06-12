import 'package:personal_flow/domain/task/task.args.dart'
    show
        TaskDeleteArgs,
        TaskFindAllArgs,
        TaskFindArgs,
        TaskSaveArgs,
        TaskSaveListArgs,
        TaskUpdateArgs;
import 'package:personal_flow/domain/task/task.entity.dart';

mixin TaskRepositoryInterface {
  Future<TaskEntity> find(TaskFindArgs args);
  Future<TaskEntity> findAll(TaskFindAllArgs args);
  Future<TaskEntity> save(TaskSaveArgs args);
  Future<TaskEntity> saveList(TaskSaveListArgs args);
  Future<TaskEntity> update(TaskUpdateArgs args);
  Future<TaskEntity> delete(TaskDeleteArgs args);
}
