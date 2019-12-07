import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';
import 'package:personal_flow/view/desempenho/componentes/mensal.dart';
import 'package:personal_flow/view/desempenho/componentes/seletorDesempenho.dart';
import 'package:personal_flow/view/desempenho/componentes/semanal.dart';

String _tipo = "desempenho";
double _tamanhoTela = 0;

class Desempenho extends StatefulWidget {
  Desempenho({Key key}): super(key: key);

  @override
  _DesempenhoState createState() => _DesempenhoState();
}

class _DesempenhoState extends State<Desempenho> {
  @override
  Widget build(BuildContext context) {
    setState(()=> _tamanhoTela = MediaQuery.of(context).size.width);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            tituloPaginas(_tipo, _tamanhoTela),
            Seletor(),
            Semanal(),
            Mensal(),
          ],
        ),
      ),
    );
  }
}
