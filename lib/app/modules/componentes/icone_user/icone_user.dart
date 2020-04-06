import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'icone_user_controller.dart';

class IconUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;
    final controller = Modular.get<IconUserController>();

    return IconButton(
      icon: CircleAvatar(
        child: Icon(Icons.person_outline, color: Colors.grey),
        backgroundColor: Color.fromRGBO(128, 128, 128, 0.2),
      ),
      onPressed: () => controller.modalUser(context, tamanhoTela),
    );
  }
}
