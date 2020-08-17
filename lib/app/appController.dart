import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'appController.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  String initialRoute = "/";
  ThemeData themeData = ThemeData(primarySwatch: Colors.red);
}
