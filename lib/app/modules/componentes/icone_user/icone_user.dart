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
        child: Icon(Icons.person_outline, color: Colors.grey[600]),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.5),
      ),
      onPressed: () => controller.modalUser(context, tamanhoTela),
    );
  }
}
