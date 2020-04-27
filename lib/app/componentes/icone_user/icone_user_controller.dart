import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'componentes/modal/modal_user.dart';

part 'icone_user_controller.g.dart';

class IconUserController = IconUserControllerBase with _$IconUserController;

abstract class IconUserControllerBase with Store {
  @action
  void modalUser(BuildContext context, double tamanhoTela) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(tamanhoTela * 0.025),
                topRight: Radius.circular(tamanhoTela * 0.025))),
        context: context,
        builder: (_) => ModalUser(tamanhoTela: tamanhoTela));
  }
}
