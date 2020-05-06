import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../login_controller.dart';

class BtnLoginFacebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;
    return Container(
        child: FlatButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(tamanhoTela * 0.1)),
            label: Icon(EvaIcons.facebook,
                color: Colors.blue, size: tamanhoTela * 0.04),
            color: Colors.blue[900].withOpacity(0.1),
            icon: Text("Facebook", style: TextStyle(color: Colors.blue)),
            onPressed: () =>
                Modular.get<LoginController>().loginWith("facebook")));
  }
}
