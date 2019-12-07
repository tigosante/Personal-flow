import 'package:flutter/material.dart';
import 'package:personal_flow/controller/composta.dart';

CheckBoxComposta checkBoxComposta = CheckBoxComposta();

class IconeSubtarefa extends StatefulWidget {
  IconeSubtarefa({Key key}): super(key: key);

  @override
  _IconeSubtarefaState createState() => _IconeSubtarefaState();
}

class _IconeSubtarefaState extends State<IconeSubtarefa> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
          icon     : checkBoxComposta.mudarEstado(),
          onPressed: () => setState(() {
                checkBoxComposta.estadoSet = checkBoxComposta.estadoGet;
              })),
    );
  }
}
