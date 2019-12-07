import 'package:flutter/material.dart';

double _tamanhoTela = 0;

class BotoesSeletores extends StatefulWidget {
  BotoesSeletores({Key key, this.texto}) : super(key: key);

  String texto;
  @override
  _BotoesState createState() => _BotoesState();
}

class _BotoesState extends State<BotoesSeletores> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Padding(
      padding: EdgeInsets.all(_tamanhoTela * 0.02),
      child  : Text(
        widget.texto,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}