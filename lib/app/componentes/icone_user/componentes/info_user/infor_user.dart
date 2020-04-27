import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/screens/login/login_controller.dart';

import '../../icone_user.dart';

class InfoUser extends StatelessWidget {
  final controller = Modular.get<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
          child: ListTile(
              title: Text(controller.authController.user.displayName ?? ""),
              subtitle: Text(controller.authController.user.email ?? ""),
              leading: IconUser(),
              trailing: IconButton(
                  icon: Icon(Icons.exit_to_app, color: Colors.red),
                  onPressed: controller.logOut)))
    ]);
  }
}
