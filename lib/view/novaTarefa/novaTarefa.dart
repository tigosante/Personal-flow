import 'package:flutter/material.dart';
import 'package:personal_flow/view/novaTarefa/componentes/corpo.dart';

class NovaTarefa extends StatefulWidget {
  NovaTarefa({Key key}): super(key: key);

  @override
  _NovaTarefaState createState() => _NovaTarefaState();
}

class _NovaTarefaState extends State<NovaTarefa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Nova Tarefa",
            style: TextStyle(color: Colors.amber[700]),
          ),
          elevation      : 0,
          backgroundColor: Colors.transparent,
          iconTheme      : IconThemeData(color: Colors.amber[700]),
        ),
        body                : Corpo(),
        floatingActionButton: FloatingActionButton.extended(
          splashColor: Colors.indigo[900],
          label      : Text(
            "Adicionar",
            style: TextStyle(color: Colors.amber),
          ),
          icon: Icon(
            Icons.add,
            color: Colors.amber,
          ),
          backgroundColor: Colors.indigo[700],
          onPressed      : () {
            Navigator.pop(context);
          },
        ));
  }
}
