import 'package:flutter/material.dart';
import 'package:personal_flow/controller/tarefas/composta/controllerComposta.dart';

double _tamanhoTela = 0.0;
String tipo = "adicionar";

class AdiconarSubtarefa extends StatefulWidget {
  AdiconarSubtarefa({Key key}) : super(key: key);

  @override
  _AdiconarSubtarefaState createState() => _AdiconarSubtarefaState();
}

class _AdiconarSubtarefaState extends State<AdiconarSubtarefa> {
  @override
  Widget build(BuildContext context) {
    setState(()=> _tamanhoTela = MediaQuery.of(context).size.width);
    return Padding(
      padding: EdgeInsets.only(
        top: _tamanhoTela * 0.02,
        bottom: _tamanhoTela * 0.02,
      ),
      child: InkWell(
        splashColor: Colors.teal[50],
        highlightColor: Colors.teal[50],
        borderRadius: BorderRadius.circular(_tamanhoTela * 0.02),
        child: Container(
          margin: EdgeInsets.only(
            top: _tamanhoTela * 0.025,
            left: _tamanhoTela * 0.12,
            right: _tamanhoTela * 0.12,
            bottom: _tamanhoTela * 0.025,
          ),
          child: Text(
            "Adiconar subtarefa",
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        onTap: ()=> modal(context, _tamanhoTela, tipo, ""),
      ),
    );
  }
}