import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/screens/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: RaisedButton(
              child: Text("Login Google"),
              onPressed: Modular.get<LoginController>().loginWithGoogle),
        ),
      );
}
