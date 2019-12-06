import 'package:flutter/material.dart';

double _tamanhoTela = 0;

class DataHora extends StatefulWidget {
  DataHora({Key key}): super(key: key);
  @override
  _DataHoraState createState() => _DataHoraState();
}

class _DataHoraState extends State<DataHora> {
  @override
  Widget build(BuildContext context) {
    setState(() => _tamanhoTela = MediaQuery.of(context).size.width);

    return Container(
      child : Row(
        children: <Widget>[
          Text("Data"),
          Text(" e "),
          Text("hora"),
          Container(
            margin: EdgeInsets.only(
                top: _tamanhoTela * 0.002, left: _tamanhoTela * 0.005),
            child: InkWell(
              borderRadius: BorderRadius.circular(_tamanhoTela * 0.01),
              child       : Icon(
                Icons.close,
                color: Colors.red,
              ),
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
