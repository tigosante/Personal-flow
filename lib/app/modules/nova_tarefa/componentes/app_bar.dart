import 'package:flutter/material.dart';

class NovaTarefaBar extends StatelessWidget {
  NovaTarefaBar({Key key, this.tamanhoTela}) : super(key: key);

  final double tamanhoTela;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tamanhoTela,
      height: tamanhoTela * 0.2,
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.only(top: tamanhoTela * 0.05),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
                splashColor: Colors.white24,
                child: Icon(Icons.chevron_left, color: Colors.white),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(tamanhoTela * 0.1)),
                onPressed: () => Navigator.pop(context)),
            Padding(
                padding: EdgeInsets.only(right: tamanhoTela * 0.05),
                child: Text("Nova Tarefa",
                    style: TextStyle(
                        color: Colors.white, fontSize: tamanhoTela * 0.045)))
          ],
        ),
      ),
    );
  }
}
