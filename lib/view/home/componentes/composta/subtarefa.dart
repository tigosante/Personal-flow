import 'package:flutter/material.dart';
import 'package:personal_flow/view/home/componentes/composta/dateHora.dart';
import 'package:personal_flow/view/home/componentes/composta/iconeSubtarefa.dart';
import 'package:personal_flow/view/home/componentes/composta/tituloSubtarefa.dart';

double _tamanhoTela = 0;

class Subtarefa extends StatefulWidget {
  Subtarefa({Key key}) : super(key: key);

  @override
  _SubtarefaCompostaState createState() => _SubtarefaCompostaState();
}

class _SubtarefaCompostaState extends State<Subtarefa> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Container(
      margin: EdgeInsets.only(
        bottom: _tamanhoTela * 0.02
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            TituloSubtarefa(),
            DataHora(),
            ],
          ),
          IconeSubtarefa(),
        ],
      ),
    );
  }
}