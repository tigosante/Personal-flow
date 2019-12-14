import 'package:flutter/material.dart';
import 'package:personal_flow/controller/composta.dart';

class IconeSubtarefa extends StatefulWidget {
  IconeSubtarefa({Key key, this.concluida}): super(key: key);

  bool concluida;
  @override
  _IconeSubtarefaState createState() => _IconeSubtarefaState();
}

class _IconeSubtarefaState extends State<IconeSubtarefa> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
          icon     : mudarEstado(widget.concluida),
          onPressed: () => setState(() {
                widget.concluida = !widget.concluida;
              })),
    );
  }
}
