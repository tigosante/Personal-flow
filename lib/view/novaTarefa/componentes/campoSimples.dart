import 'package:flutter/material.dart';
import 'package:personal_flow/view/home/componentes/composta/dateHora.dart';

double _tamanhoTela = 0;

class CampoSimples extends StatefulWidget {
  CampoSimples({Key key}): super(key: key);

  @override
  _CampoSimplesState createState() => _CampoSimplesState();
}

class _CampoSimplesState extends State<CampoSimples> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller;

    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Container(
      width: _tamanhoTela * 0.95,
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(_tamanhoTela * 0.025)
      ),
      child: ListTile(
        title: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Tarefa",
            border: InputBorder.none,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(
            bottom: _tamanhoTela * 0.02
          ),
          child: DataHora(),
        ),
      ),
    );
  }
}
