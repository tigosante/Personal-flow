import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/modules/componentes/data_hora/data_hora.dart';
import 'package:personalflow/app/modules/nova_tarefa/componentes/new_task_composed/subtarefa_input/subtarefa_input.dart';

import '../../nova_tarefa_controller.dart';

class NewTaskComposed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;
    final controller = Modular.get<NovaTarefaController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: tamanhoTela * 0.9,
          child: Card(
              color: Colors.red.withOpacity(0.5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(tamanhoTela * 0.05)),
              child: ListTile(
                title: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Título da Tarefa"),
                ),
                subtitle: DataHora(),
              )),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("Acionar subtarefa",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: tamanhoTela * 0.04,
                    color: Colors.teal[600],
                    letterSpacing: tamanhoTela * 0.002)),
            IconButton(
                icon: Icon(Icons.add_circle, color: Colors.yellow[900]),
                onPressed: () {})
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Observer(
              builder: (_) => Column(
                children: controller.subtarefas
                    .map((subtarefa) => SubtarefaInput(
                        subtarefa: subtarefa.title, tamanhoTela: tamanhoTela))
                    .toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
