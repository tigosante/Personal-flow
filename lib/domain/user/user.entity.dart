import 'package:personal_flow/domain/task/task.entity.dart';

class UserEntity {
  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.tasks,
  });

  final int id;
  final String name;
  final String email;
  final List<TaskEntity> tasks;
}
