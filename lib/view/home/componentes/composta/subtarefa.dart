import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';
import 'package:personal_flow/view/home/componentes/composta/dateHora.dart';
import 'package:personal_flow/view/home/componentes/composta/iconeSubtarefa.dart';
import 'package:personal_flow/view/home/componentes/composta/tituloSubtarefa.dart';

double _tamanhoTela = 0;
String _tipo        = "editar";

class Subtarefa extends StatefulWidget {
  Subtarefa({Key key}): super(key: key);

  @override
  _SubtarefaCompostaState createState() => _SubtarefaCompostaState();
}

class _SubtarefaCompostaState extends State<Subtarefa> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return ListTile(
      title   : TituloSubtarefa(),
      subtitle: DataHora(),
      trailing: IconeSubtarefa(),
      onTap   : () => modal(context, _tamanhoTela, _tipo, "tarefa"),
    );
  }
}
