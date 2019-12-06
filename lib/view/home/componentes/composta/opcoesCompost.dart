import 'package:flutter/material.dart';
import 'package:personal_flow/controller/tarefas/composta/controllerComposta.dart';

double _tamanhoTela = 0;

class OpcoesComposta extends StatefulWidget {
  OpcoesComposta({Key key}): super(key: key);

  @override
  _OpcoesCompostaState createState() => _OpcoesCompostaState();
}

class _OpcoesCompostaState extends State<OpcoesComposta> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);
    return Row(
      mainAxisSize     : MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children         : geradorBotoes(_tamanhoTela, 4),
    );
  }
}
