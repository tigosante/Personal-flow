import 'package:flutter/material.dart';

class Cabeca extends StatefulWidget {
  Cabeca({Key key, this.titulo}) : super(key: key);

  String titulo;

  @override
  _CabecaState createState() => _CabecaState();
}

class _CabecaState extends State<Cabeca> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text(
            widget.titulo,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text("Você já concluiu 50% de todas as tarefas!"),
        ),
      ],
    );
  }
}
