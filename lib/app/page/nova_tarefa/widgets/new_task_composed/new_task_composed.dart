import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/page/nova_tarefa/widgets/add_subtarefa/add_subtarefa.dart';
import 'package:personalflow/app/page/nova_tarefa/widgets/card_titulo_composta/card_titulo_composta.dart';
import 'package:personalflow/app/page/nova_tarefa/widgets/new_task_composed/subtarefa_input/subtarefa_input.dart';

import '../../nova_tarefa_controller.dart';

class NewTaskComposed extends StatelessWidget {
  final controller = Modular.get<NovaTarefaController>();

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
        padding:
            EdgeInsets.only(top: tamanhoTela * 0.02, bottom: tamanhoTela * 0.2),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          CardTituloComposta(),
          Column(children: <Widget>[
            AddSubtarefa(),
            Observer(
                builder: (_) => Column(
                    children: controller.subtarefas
                        .map((subtarefa) => SubtarefaInput(
                            subtarefa: subtarefa.title,
                            tamanhoTela: tamanhoTela))
                        .toList()))
          ])
        ]));
  }
}
