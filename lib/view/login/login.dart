import 'package:flutter/material.dart';
import 'package:personal_flow/view/login/componentes/entrar.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Entrar()),
    );
  }
}