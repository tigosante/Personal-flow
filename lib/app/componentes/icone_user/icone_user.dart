import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/componentes/icone_user/componentes/info_user/photo_user.dart';

import 'icone_user_controller.dart';

class IconUser extends StatefulWidget {
  @override
  _IconUserState createState() => _IconUserState();
}

class _IconUserState extends State<IconUser> {
  final controller = Modular.get<IconUserController>();

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return IconButton(
        icon: PhotoUser(),
        onPressed: () => controller.modalUser(context, tamanhoTela));
  }
}
