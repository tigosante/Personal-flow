import 'package:personal_flow/domain/user/user.entity.dart';
import 'package:personal_flow/domain/user/user.args.dart'
    show UserFindArgs, UserSaveArgs, UserUpdateArgs;
import 'package:personal_flow/domain/user/user.repository.interface.dart';

class UserRepository implements UserRepositoryInterface {
  @override
  Future<UserEntity> find(UserFindArgs args) {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> save(UserSaveArgs args) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> update(UserUpdateArgs args) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
