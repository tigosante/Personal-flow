import 'package:flutter/material.dart';
import 'componentes/new_task_body/new_task_body.dart';
import 'componentes/tabs_new_task/tab_composta.dart';
import 'componentes/tabs_new_task/tab_simples.dart';

class NovaTarefaPage extends StatelessWidget {
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TabComposta(tamanhoTela: tamanhoTela),
              TabSimples(tamanhoTela: tamanhoTela)
            ]));
  }
}
