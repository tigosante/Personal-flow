import 'package:flutter/material.dart';

double _tamanhoTela = 0;

class TituloSubtarefa extends StatefulWidget {
  TituloSubtarefa({Key key}) : super(key: key);

  @override
  _TituloSubtarefaState createState() => _TituloSubtarefaState();
}

class _TituloSubtarefaState extends State<TituloSubtarefa> {
  @override
  Widget build(BuildContext context) {
    setState(()=> _tamanhoTela = MediaQuery.of(context).size.width);

    return Container(
      child: Container(
        margin: EdgeInsets.only(
          top: _tamanhoTela * 0.01,
          left: _tamanhoTela * 0.02,
          bottom: _tamanhoTela * 0.01,
        ),
        child: Text("Título da subtarefa"),
      ),
    );
  }
}