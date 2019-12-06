import 'package:flutter/material.dart';
import 'package:personal_flow/view/home/componentes/composta/dateHora.dart';

double _tamanhoTela = 0;

class NovaSubComposta extends StatefulWidget {
  NovaSubComposta({Key key}): super(key: key);

  @override
  _NovaSubCompostaState createState() => _NovaSubCompostaState();
}

class _NovaSubCompostaState extends State<NovaSubComposta> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller;
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Container(
      decoration: BoxDecoration(
          color       : Colors.indigo[50],
          borderRadius: BorderRadius.circular(_tamanhoTela * 0.025)),
      child: ListTile(
        title: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Tarefa",
            border  : InputBorder.none,
          ),
        ),
        subtitle: DataHora(),
        trailing: IconButton(
          icon: Icon(
            Icons.add_circle,
            color: Colors.indigo,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
