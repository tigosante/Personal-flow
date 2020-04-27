import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:personalflow/app/screens/login/login_controller.dart';
import 'package:personalflow/core/controller/login/auth_controller.dart';

import 'icone_user_controller.dart';

class IconUser extends StatefulWidget {
  @override
  _IconUserState createState() => _IconUserState();
}

class _IconUserState extends State<IconUser> {
  final controller = Modular.get<IconUserController>();
  final loginCtrl = Modular.get<LoginController>();
  Widget img;

  ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _disposer = autorun((_) {
      AuthStatus status = Modular.get<AuthController>().status;

      if (status == AuthStatus.logoff)
        img = Icon(Icons.person_outline, color: Colors.grey[600]);
      else if (status == AuthStatus.login)
        img = Image.network(loginCtrl.authController.user.photoUrl);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _disposer();
  }

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return IconButton(
        icon: CircleAvatar(
            child: img, backgroundColor: Color.fromRGBO(255, 255, 255, 0.5)),
        onPressed: () => controller.modalUser(context, tamanhoTela));
  }
}
