import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:personalflow/app/modules/componentes/icone_user/icone_user.dart';

part 'barra_pesquisa_controller.g.dart';

class BarraPesquisaController = _BarraPesquisaControllerBase
    with _$BarraPesquisaController;

abstract class _BarraPesquisaControllerBase with Store {
  @observable
  Widget iconBarra = IconUser();
}
