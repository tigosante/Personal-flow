import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:personalflow/core/controllers/auth_controller.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _disposer = autorun((_) {
      AuthStatus status = Modular.get<AuthController>().status;

      if (status == AuthStatus.logoff)
        Modular.to.pushReplacementNamed("/login");
      else if (status == AuthStatus.login)
        Modular.to.pushReplacementNamed("/home");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _disposer();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: CircularProgressIndicator()));
}
