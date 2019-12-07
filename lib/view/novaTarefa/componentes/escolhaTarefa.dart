import 'package:flutter/material.dart';

double _tamanhoTela = 0;

class EscolhaTarefa extends StatefulWidget {
  EscolhaTarefa({Key key}) : super(key: key);

  @override
  _EscolhaTarefaState createState() => _EscolhaTarefaState();
}

class _EscolhaTarefaState extends State<EscolhaTarefa> {
  @override
  Widget build(BuildContext context) {
    setState(()=> _tamanhoTela = MediaQuery.of(context).size.width);

    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: _tamanhoTela * 0.02,
          bottom: _tamanhoTela * 0.01,
        ),
        child: Container(
          padding: EdgeInsets.all(_tamanhoTela * 0.03),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.indigo
            ),
            borderRadius: BorderRadius.circular(_tamanhoTela * 0.05),
          ),
          child: Text(
            "Escolha um tipo de tarefa",
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.indigo),
          ),
        ),
      ),
    );
  }
}