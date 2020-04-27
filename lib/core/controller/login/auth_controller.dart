import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:personalflow/core/model/login/login_repository_interface.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final ILoginRepository _iAuthRepository = Modular.get();

  @observable
  AuthStatus status = AuthStatus.loading;

  @observable
  FirebaseUser user;

  _AuthControllerBase() {
    _iAuthRepository.getUser().then((setUser));
  }

  @action
  void setUser(FirebaseUser value) {
    user = value;
    status = user == null ? AuthStatus.logoff : AuthStatus.login;
  }

  Future authWithGoogle() async =>
      user = await _iAuthRepository.getGoogleLogin();

  Future logOut() async => user = await _iAuthRepository.getLogOut();
}

enum AuthStatus { loading, login, logoff }
