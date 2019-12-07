import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';

double _tamanhoTela = 0;

class Agendar extends StatefulWidget {
  Agendar({Key key, this.cor}): super(key: key);

  Color cor;

  @override
  _AgendarState createState() => _AgendarState();
}

class _AgendarState extends State<Agendar> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Container(
      padding: EdgeInsets.only(
          right: _tamanhoTela * 0.1, bottom: _tamanhoTela * 0.05),
      child: Column(
        mainAxisSize      : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children          : <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top   : _tamanhoTela * 0.01,
                left  : _tamanhoTela * 0.017,
                bottom: _tamanhoTela * 0.01),
            child: Text(
              "Dias que a terefa se repete.",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Wrap(children: geradorListaDias(widget.cor)),
        ],
      ),
    );
  }
}
