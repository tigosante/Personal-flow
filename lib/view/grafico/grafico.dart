import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';

String _tipo = "grafico";
double _tamanhoTela = 0;

class Grafico extends StatefulWidget {
  Grafico({Key key}): super(key: key);

  @override
  _GraficoState createState() => _GraficoState();
}

class _GraficoState extends State<Grafico> {
  @override
  Widget build(BuildContext context) {
    setState(()=> _tamanhoTela = MediaQuery.of(context).size.width);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            tituloPaginas(_tipo, _tamanhoTela),
          ],
        ),
      ),
    );
  }
}
