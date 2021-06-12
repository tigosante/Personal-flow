import 'package:personal_flow/domain/user/user.entity.dart';
import 'package:personal_flow/domain/user/user.args.dart'
    show UserFindArgs, UserSaveArgs, UserUpdateArgs;
import 'package:personal_flow/domain/user/user.repository.interface.dart';

class UserRepository implements UserRepositoryInterface {
  @override
  Future<UserEntity> find(UserFindArgs args) async {
    return UserEntity();
  }

  @override
  Future<UserEntity> save(UserSaveArgs args) async {
    return UserEntity();
  }

  @override
  Future<UserEntity> update(UserUpdateArgs args) async {
    return UserEntity();
  }
}
