import 'package:personal_flow/domain/user/user.args.dart'
    show UserFindArgs, UserUpdateArgs;
import 'package:personal_flow/domain/user/user.entity.dart';

mixin UserRepositoryInterface {
  Future<UserEntity> find(UserFindArgs args);
  Future<UserEntity> update(UserUpdateArgs args);
}
