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
          borderRadius: BorderRadius.circular(_tamanhoTela * 0.025)),
      child: ListTile(
        title: TextField(
          controller: controller,
          minLines: 1,
          maxLines: 8,
          decoration: InputDecoration(
            hintText: "Tarefa",
            border  : InputBorder.none,
          ),
        ),
        subtitle: DataHora(data: "08/12/12", hora: "00:00"),
        trailing: IconButton(
          icon: Icon(
            Icons.add_circle,
            color: Colors.amber[700],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
