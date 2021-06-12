import 'package:flutter/material.dart';
import 'package:personal_flow/router/router.application.gr.dart';

void main() {
  runApp(PersonalFlowApp());
}

class PersonalFlowApp extends StatelessWidget {
  final _router = RouterApplication();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
    );
  }
}
