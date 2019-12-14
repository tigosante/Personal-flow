import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';
import 'package:personal_flow/view/home/componentes/composta/dateHora.dart';
import 'package:personal_flow/view/home/componentes/composta/iconeSubtarefa.dart';
import 'package:personal_flow/view/home/componentes/composta/tituloSubtarefa.dart';

double _tamanhoTela = 0;
String _tipo        = "editar";

class Subtarefa extends StatefulWidget {
  Subtarefa({Key key, this.titulo, this.data, this.hora, this.concluida})
      :  super(key: key);

  bool concluida;
  String titulo;
  String data;
  String hora;
  @override
  _SubtarefaCompostaState createState() => _SubtarefaCompostaState();
}

class _SubtarefaCompostaState extends State<Subtarefa> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return ListTile(
      title: Padding(
        padding: EdgeInsets.only(top: _tamanhoTela * 0.02),
        child  : TituloSubtarefa(titulo: widget.titulo),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(
            bottom: widget.data == "" ? _tamanhoTela * 0.05 : 0),
        child: DataHora(
          data: widget.data,
          hora: widget.hora,
        ),
      ),
      trailing: IconeSubtarefa(
        concluida: widget.concluida,
      ),
      onTap: () => modal(context, _tamanhoTela, _tipo, widget.titulo),
    );
  }
}
