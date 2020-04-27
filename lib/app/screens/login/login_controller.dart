import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:personalflow/core/controller/login/auth_controller.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  AuthController authController = Modular.get();

  @observable
  bool load = false;

  @action
  Future loginWithGoogle() async {
    try {
      load = true;
      await authController.authWithGoogle();
      Modular.to.pushReplacementNamed("/home");
    } catch (e) {
      load = false;
    }
  }

  @action
  Future logOut() async {
    try {
      await Modular.get<AuthController>().logOut();
      Modular.to.pushReplacementNamed("/login");
    } catch (e) {
      //
    }
  }
}
