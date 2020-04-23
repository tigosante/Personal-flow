import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/modules/nova_tarefa/componentes/data_hora/data_hora_nova_tarefa.dart';

import '../../nova_tarefa_controller.dart';

class NewTaskSimple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<NovaTarefaController>();
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: tamanhoTela * 0.02),
            child: Container(
              width: tamanhoTela * 0.95,
              child: Card(
                  elevation: 0,
                  color: Colors.blue[700].withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(tamanhoTela * 0.05)),
                  child: ListTile(
                      title: Observer(builder: (_) {
                        return TextField(
                            controller: controller.cSimples,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Título da Tarefa"));
                      }),
                      subtitle: DataHoraNovaTarefa())),
            )),
      ],
    );
  }
}
