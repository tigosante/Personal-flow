
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/controller/composta.dart';
import 'package:personal_flow/view/desempenho/componentes/geral/cabeca.dart';
import 'package:personal_flow/view/desempenho/componentes/geral/detalhes.dart';

double _tamanhoTela = 0;

class Mensal extends StatefulWidget {
  Mensal({Key key}) : super(key: key);

  @override
  _MensalState createState() => _MensalState();
}

class _MensalState extends State<Mensal> {
  @override
  Widget build(BuildContext context) {
    setState(()=> _tamanhoTela = MediaQuery.of(context).size.width);

    return Container(
      width: _tamanhoTela * 0.95,
      child: Card(
        elevation: 1,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_tamanhoTela * 0.04),
        ),
        child: ExpandablePanel(
          tapHeaderToExpand: true,
          header: Cabeca(titulo: "Mensal",),
          collapsed: barraProgresso(Colors.amber[700]),
          expanded: Detalhes(),
        ),
      ),
    );
  }
}