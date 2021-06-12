import 'package:personal_flow/domain/auth/auth.entity.dart';
import 'package:personal_flow/domain/auth/repositorys/auth.access.repository.interface.dart';

class AuthEmailRepository implements AuthAccessRepositoryInterface {
  @override
  Future<AuthEntity> signIn() async {
    return AuthEntity();
  }

  @override
  Future<bool> signOut() async {
    return true;
  }

  @override
  Future<AuthEntity> signUp() async {
    return AuthEntity();
  }
}
