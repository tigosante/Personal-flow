import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/componentes/icone_user/componentes/info_user/photo_user.dart';
import 'package:personalflow/app/screens/login/login_controller.dart';

class InfoUser extends StatelessWidget {
  final controller = Modular.get<LoginController>();

  @override
  Widget build(BuildContext context) => Row(children: <Widget>[
        Expanded(
            child: ListTile(
                title: Text(controller.authController.user.displayName ?? ""),
                subtitle: Text(controller.authController.user.email ?? ""),
                leading: PhotoUser(),
                trailing: IconButton(
                    icon: Icon(Icons.exit_to_app, color: Colors.red),
                    onPressed: controller.logOut)))
      ]);
}
