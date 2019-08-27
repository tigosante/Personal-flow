import 'package:flutter/material.dart';

import 'package:projeto_integrador_i/ui/login_page.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Projeto Integrador I',

      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),

      home: new LoginPage(),

    );

  }

}