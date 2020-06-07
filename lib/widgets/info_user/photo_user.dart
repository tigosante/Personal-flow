import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:personalflow/core/controllers/auth_controller.dart';
import 'package:personalflow/pages/login/controllers/login_controller.dart';

class PhotoUser extends StatefulWidget {
  @override
  _PhotoUserState createState() => _PhotoUserState();
}

class _PhotoUserState extends State<PhotoUser> {
  final authController = Modular.get<LoginController>().authController;
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
        img = ClipOval(child: Image.network(authController.user.photoUrl));
    });
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CircleAvatar(child: img);
}
