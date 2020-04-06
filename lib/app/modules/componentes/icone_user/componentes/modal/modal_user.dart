import 'package:flutter/material.dart';
import 'package:personalflow/app/modules/componentes/icone_user/componentes/info_user/infor_user.dart';

class ModalUser extends StatelessWidget {
  ModalUser({Key key, this.tamanhoTela}) : super(key: key);

  final double tamanhoTela;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IngoUser(),
      ],
    );
  }
}
