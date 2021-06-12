import 'package:personal_flow/domain/auth/auth.entity.dart';

mixin AuthAccessRepositoryInterface {
  Future<AuthEntity> signIn();
  Future<AuthEntity> signUp();
  Future<bool> signOut();
}
