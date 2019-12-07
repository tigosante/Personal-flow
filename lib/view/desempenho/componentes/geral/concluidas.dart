import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';
import 'package:personal_flow/view/home/componentes/composta/subtarefa.dart';

double _tamanhoTela = 0;

class Concluidas extends StatefulWidget {
  Concluidas({Key key}) : super(key: key);

  @override
  _SemanalConcluidasState createState() => _SemanalConcluidasState();
}

class _SemanalConcluidasState extends State<Concluidas> {
  @override
  Widget build(BuildContext context) {
    setState(()=> _tamanhoTela = MediaQuery.of(context).size.width);

    return Container(
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: _tamanhoTela * 0.05,
                left: _tamanhoTela * 0.04,
              ),
              child: Text(
                "Concluídas",
                style: TextStyle(
                  color: Colors.amber[700],
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: geradorLista(3, Subtarefa()),
            ),
          ],
        ),
      ),
    );
  }
}