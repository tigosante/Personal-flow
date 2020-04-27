import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/screens/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  final controller = Modular.get<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(),
            TextField(),
            RaisedButton(
              child: Text("Login Google"),
              onPressed: controller.loginWithGoogle,
            )
          ],
        ),
      ),
    );
  }
}
