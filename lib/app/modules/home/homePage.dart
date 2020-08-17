import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'homeController.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Tarefas"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<Response>(
        future: controller.tasks,
        builder: (_, AsyncSnapshot snapshot) =>
            controller.getAllTasks(snapshot),
      ),
    );
  }
}
