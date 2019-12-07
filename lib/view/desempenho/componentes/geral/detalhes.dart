import 'package:flutter/material.dart';
import 'package:personal_flow/controller/composta.dart';
import 'package:personal_flow/view/desempenho/componentes/geral/concluidas.dart';
import 'package:personal_flow/view/desempenho/componentes/geral/naoConcluidas.dart';
double _tamanhoTela = 0;

class Detalhes extends StatefulWidget {
  Detalhes({Key key}) : super(key: key);

  @override
  _DetalhesState createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {
  @override
  Widget build(BuildContext context) {
    setState(()=> _tamanhoTela = MediaQuery.of(context).size.width);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: _tamanhoTela * 0.85,
          child: barraProgresso(Colors.amber[700])
        ),
        NaoConcluidas(),
        Concluidas(),
      ],
    );
  }
}