import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'nova_tarefa_controller.dart';

class NovaTarefaPage extends StatefulWidget {
  final String title;
  const NovaTarefaPage({Key key, this.title = "NovaTarefa"}) : super(key: key);

  @override
  _NovaTarefaPageState createState() => _NovaTarefaPageState();
}

class _NovaTarefaPageState extends State<NovaTarefaPage> {
  final controller = Modular.get<NovaTarefaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
