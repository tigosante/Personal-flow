import 'package:flutter/material.dart';
import 'package:personal_flow/view/home/tarefas/composta.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
         appBar: AppBar(
          title: Text("Personal Flow"),
         ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Composta(),
            // TarefaSimples(),
          ],
        ),
      ),
    );
  }
}
