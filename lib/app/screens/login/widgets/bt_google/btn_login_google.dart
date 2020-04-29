import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/screens/login/login_controller.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class BtnLoginGoogle extends StatelessWidget {
  BtnLoginGoogle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      child: CircleAvatar(
          child: IconButton(
              color: Colors.blue[600],
              icon: Icon(EvaIcons.google),
              onPressed: Modular.get<LoginController>().loginWithGoogle),
          backgroundColor: Colors.grey.withOpacity(0.2)));
}
