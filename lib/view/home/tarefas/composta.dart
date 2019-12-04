import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/controller/tarefas/composta/controllerComposta.dart';
import 'package:personal_flow/view/home/componentes/composta/opcoesCompost.dart';
import 'package:personal_flow/view/home/componentes/composta/subtarefa.dart';

double _tamanhoTela = 0;

class Composta extends StatefulWidget {
  Composta({Key key}) : super(key: key);

  @override
  _CompostaState createState() => _CompostaState();
}

class _CompostaState extends State<Composta> {
  @override
  Widget build(BuildContext context) {
    setState(()=> _tamanhoTela = MediaQuery.of(context).size.width);
    
    return Center(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_tamanhoTela * 0.02),
        ),
        color: Colors.white,
        child: Container(
          width: _tamanhoTela * 0.5,
          child: ExpandablePanel(
            iconColor: Colors.blue,
            tapHeaderToExpand: true,
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            header: Container(
              margin: EdgeInsets.only(
                top: _tamanhoTela * 0.025,
                left: _tamanhoTela * 0.02,
                bottom: _tamanhoTela * 0.025
              ),
              child: Text("Título da tarefa"),
            ),
            expanded: Container(
              padding: EdgeInsets.only(
                top: _tamanhoTela * 0.02,
                bottom: _tamanhoTela * 0.02,
              ),
              child: Column(
                children: <Widget>[
                  geradorCorpo(5, Subtarefa()),
                  OpcoesComposta(),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
