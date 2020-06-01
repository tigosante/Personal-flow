import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:personalflow/core/controllers/auth_controller.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  AuthController authController = Modular.get();

  @observable
  TextEditingController controllerEmail = TextEditingController(text: "");

  @observable
  TextEditingController controllerSenhaEmail = TextEditingController(text: "");

  @action
  Future<void> loginWith(String service) async {
    try {
      switch (service) {
        case "google":
          await authController.authWithGoogle();
          break;
        default:
          await authController.signInEmail(
              controllerEmail.text.trim(), controllerSenhaEmail.text);
      }
      goToHomeScreen();
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> loginWithEmil() async {
    try {
      await authController.authWithGoogle();
      goToHomeScreen();
    } catch (e) {
      print(e);
    }
  }

  @action
  Future logOut() async {
    try {
      await authController.logOut();
      goToLoginScreen();
    } catch (e) {
      print(e);
    }
  }

  void goToHomeScreen() => Modular.to.pushReplacementNamed("/home");
  void goToLoginScreen() => Modular.to.pushReplacementNamed("/login");
}
