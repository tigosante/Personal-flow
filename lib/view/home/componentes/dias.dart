import 'package:flutter/material.dart';

bool   _selecionado = false;
double _tamanhoTela = 0;

class Dias extends StatefulWidget {
  Dias({Key key, this.dias, this.cor}): super(key: key);

  String dias;
  Color cor;

  @override
  _DiasState createState() => _DiasState();
}

class _DiasState extends State<Dias> {

  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Card(
      color       : _selecionado ? widget.cor : Color.fromRGBO(242, 242, 242, 0.8),
      elevation   : 0.1,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape       : RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_tamanhoTela * 0.025),
      ),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(
            top   : _tamanhoTela * 0.008,
            bottom: _tamanhoTela * 0.008,
          ),
          child: Text(
            widget.dias,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color     : _selecionado ? Colors.white: Colors.grey[800]),
          ),
        ),
        onTap: () {
          setState(() => _selecionado = _selecionado ? false : true);
        },
      ),
    );
  }
}
