import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/screens/nova_tarefa/widgets/new_task_body/new_task_body.dart';
import 'nova_tarefa_controller.dart';

class NovaTarefaPage extends StatelessWidget {
  final controller = Modular.get<NovaTarefaController>();

  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            leading: Container(
                width: tamanhoTela * 0.13,
                child: FlatButton(
                    splashColor: Colors.white24,
                    child: Icon(Icons.chevron_left, color: Colors.teal),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(tamanhoTela * 0.1)),
                    onPressed: () => Navigator.pop(context))),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: tamanhoTela * 0.05, right: tamanhoTela * 0.05),
                  child: Text("Nova Tarefa",
                      style: TextStyle(
                          color: Colors.teal[800],
                          fontSize: tamanhoTela * 0.045,
                          fontWeight: FontWeight.bold,
                          letterSpacing: tamanhoTela * 0.0025)))
            ]),
        body: NewTaskBody(),
        floatingActionButton: Observer(
            builder: (BuildContext context) => FloatingActionButton(
                child: controller.iconButtonNewTask,
                backgroundColor: Colors.indigo,
                onPressed: () => controller.novaTarefa(context))),
        bottomNavigationBar: Observer(
            builder: (_) => BottomNavigationBar(
                  elevation: 0,
                  onTap: controller.changeTask,
                  currentIndex: controller.indexPage,
                  backgroundColor: Colors.transparent,
                  selectedItemColor: Colors.red,
                  items: [
                    {
                      "title": "Composta",
                      "icon": Icon(Icons.playlist_add_check)
                    },
                    {"title": "Simples", "icon": Icon(Icons.check)}
                  ]
                      .map((value) => BottomNavigationBarItem(
                          icon: value["icon"],
                          title: Text(value["title"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: tamanhoTela * 0.0035))))
                      .toList(),
                )));
  }
}
