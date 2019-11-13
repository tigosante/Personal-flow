import 'package:flutter/material.dart';

class Teste extends StatefulWidget {
  Teste({Key key}) : super(key: key);

  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  @override
  Widget build(BuildContext context) {
    bool aqui = false;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(aqui ? "foi" : "sim"),
              IconButton(
                icon: aqui ? Icon(Icons.check) : Icon(Icons.check_box),
                onPressed: (){
                  setState(() { 
                    aqui = !aqui;
                    print(aqui);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}