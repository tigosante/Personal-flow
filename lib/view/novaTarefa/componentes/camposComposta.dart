import 'package:flutter/material.dart';
import 'package:personal_flow/controller/tarefas/composta/controllerComposta.dart';
import 'package:personal_flow/view/novaTarefa/componentes/novaSubComposta.dart';

double _tamanhoTela = 0;

class CamposComposta extends StatefulWidget {
  CamposComposta({Key key}) : super(key: key);

  @override
  _CamposCompostaState createState() => _CamposCompostaState();
}

class _CamposCompostaState extends State<CamposComposta> {
  @override
  Widget build(BuildContext context) {
    
    TextEditingController controller;
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Padding(
      padding: EdgeInsets.only(
        bottom: _tamanhoTela * 0.2
      ),
      child: Container(
        width: _tamanhoTela * 0.95,
        decoration: BoxDecoration(
          color: Colors.indigo[50],
          borderRadius: BorderRadius.circular(_tamanhoTela * 0.025)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
            title: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Tarefa",
                border: InputBorder.none,
              ),
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              children: geradorNovaComposta(3, NovaSubComposta()),
            )
          ),
          ],
        ),
      ),
    );
  }
}