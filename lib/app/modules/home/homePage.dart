import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'homeController.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(children: <Widget>[
        Center(
          child: TextFormField(controller: _textEditingController),
        ),
        RaisedButton(
          child: Text("Criar"),
          onPressed: () => controller.create(_textEditingController.text),
        )
      ]),
    );
  }
}
