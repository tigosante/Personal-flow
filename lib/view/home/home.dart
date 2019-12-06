import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/controller/tarefas/composta/controllerComposta.dart';
import 'package:personal_flow/view/home/tarefas/composta.dart';
import 'package:personal_flow/view/home/tarefas/simples.dart';
import 'package:personal_flow/view/novaTarefa/novaTarefa.dart';

List<Widget> _telas       = [Simples(), Composta()];
double       _tamanhoTela = 0;

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
              mainAxisAlignment: MainAxisAlignment.center,
              children         : geradorTarefas(5, _telas)),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        splashColor    : Colors.amber[800],
        hoverColor     : Colors.amber[400],
        backgroundColor: Colors.indigo[700],
        label          : Text(
          "Nova Tarefa",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => NovaTarefa(),
              ));
        },
      ),
    );
  }
}
