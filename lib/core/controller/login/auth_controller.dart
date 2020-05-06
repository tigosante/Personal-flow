import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:personalflow/core/model/login/email/email_interface.dart';
import 'package:personalflow/core/model/login/email/email_repository.dart';
import 'package:personalflow/core/model/login/google/google_interface.dart';
import 'package:personalflow/core/model/login/google/google_repository.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final EmailInterface _emailInterface = Modular.get<LoginEmailRepository>();
  final GoogleInterface _googleInterface = Modular.get<LoginGoogleRepository>();

  @observable
  AuthStatus status = AuthStatus.loading;

  @observable
  FirebaseUser user;

  _AuthControllerBase() {
    _googleInterface.getUser().then((setUser));
  }

  @action
  void setUser(FirebaseUser value) =>
      status = value == null ? AuthStatus.logoff : AuthStatus.login;

  Future<void> authWithGoogle() async =>
      user = await _googleInterface.getGoogleLogin();

  Future<void> logOut() async => user = await _googleInterface.getLogOut();

  Future<void> signInEmail(String email, String password) async =>
      user = await _emailInterface.signIn(email, password);

  Future<void> signUpEmail(String email, String password) async =>
      user = await _emailInterface.signUp(email, password);

  Future<bool> isEmailVerified() async => _emailInterface.isEmailVerified();

  void sendEmailVerification() => _emailInterface.sendEmailVerification();
}

enum AuthStatus { loading, login, logoff }
