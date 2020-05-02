import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../login_controller.dart';

class BtnLoginFacebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;
    return Container(
        child: RaisedButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(tamanhoTela * 0.1)),
            label: Icon(EvaIcons.facebook,
                color: Colors.white, size: tamanhoTela * 0.04),
            color: Colors.blue[900],
            icon: Text("Facebook", style: TextStyle(color: Colors.white)),
            onPressed: Modular.get<LoginController>().loginWithGoogle));
  }
}
