import 'package:flutter/material.dart';
import 'package:personal_flow/controller/geral.dart';

double _tamanhoTela = 0;

class DataHora extends StatefulWidget {
  DataHora({Key key, this.hora, this.data}) : super(key: key);

  String data;
  String hora;
  @override
  _DataHoraState createState() => _DataHoraState();
}

class _DataHoraState extends State<DataHora> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Container(
      child: Row(
        children: <Widget>[
          Text(verifcaDataHora(widget.data, widget.hora)),
          Divider(
            color: Colors.transparent,
            height: _tamanhoTela * 0.06,
          ),
          iconeRemover(widget.data, _tamanhoTela)
        ],
      ),
    );
  }
}
