import 'package:personal_flow/domain/user/user.entity.dart';
import 'package:personal_flow/domain/user/user.args.dart'
    show UserFindArgs, UserUpdateArgs;
import 'package:personal_flow/domain/user/user.repository.interface.dart';

class UserService {
  UserService(this._repository);
  final UserRepositoryInterface _repository;

  Future<UserEntity> find(UserFindArgs args) async {
    return _repository.find(args);
  }

  Future<UserEntity> update(UserUpdateArgs args) async {
    return _repository.update(args);
  }
}
