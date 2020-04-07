import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../app_controller.dart';

class MudarTema extends StatelessWidget {
  final controller = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text("Tema"),
        ),
        RadioListTile(
            title: Text("System"),
            value: "system",
            groupValue: controller.valorSystem,
            onChanged: controller.changeTheme,
            activeColor: Colors.purple),
        RadioListTile(
            title: Text("Light"),
            value: "light",
            groupValue: controller.valorLight,
            onChanged: controller.changeTheme,
            activeColor: Colors.purple),
        RadioListTile(
            title: Text("Dark"),
            value: "dark",
            groupValue: controller.valorDark,
            onChanged: controller.changeTheme,
            activeColor: Colors.purple),
      ],
    );
  }
}
