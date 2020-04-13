import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'componentes/app_bar.dart';
import 'componentes/new_task_body/new_task_body.dart';
import 'componentes/tabs_new_task/tabs_new_task.dart';
import 'nova_tarefa_controller.dart';

class NovaTarefaPage extends StatefulWidget {
  final String title;
  const NovaTarefaPage({Key key, this.title = "NovaTarefa"}) : super(key: key);

  @override
  _NovaTarefaPageState createState() => _NovaTarefaPageState();
}

class _NovaTarefaPageState extends State<NovaTarefaPage> {
  final controller = Modular.get<NovaTarefaController>();

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: <Widget>[
          NovaTarefaBar(tamanhoTela: tamanhoTela),
          TabsNewTask(tamanhoTela: tamanhoTela),
          NewTaskBody(),
        ],
      ),
    );
  }
}
