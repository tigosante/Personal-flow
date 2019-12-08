import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';
import 'package:personal_flow/view/novaTarefa/novaTarefa.dart';
double       _tamanhoTela = 0;

String _tipo = "tarefas";

class Home extends StatefulWidget {
  Home({Key key}): super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: _tamanhoTela * 0.02, bottom: _tamanhoTela * 0.2),
          child: Column(
            children: <Widget>[
              tituloPaginas(_tipo, _tamanhoTela),
              geradorTarefas(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation      : 0,
        splashColor    : Colors.amber[800],
        hoverColor     : Colors.amber[400],
        backgroundColor: Colors.indigo[700],
        label          : Text(
          "Nova Tarefa",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => NovaTarefa(),
            )),
      ),
    );
  }
}
