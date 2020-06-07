import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  @observable
  ThemeMode themeMode = ThemeMode.system;

  @observable
  String valorSystem = "system";

  @observable
  String valorLight = "";

  @observable
  String valorDark = "";

  @observable
  Color colorBarra = Colors.teal[900];

  @observable
  Color colorBarNewTask = Colors.indigo[900];

  Color colorBarNewTaskDark = Colors.black38;
  Color colorBarNewTaskLight = Colors.indigo[900];

  Color colorTarefaDark = Colors.white;
  Color colorTarefaLight = Colors.black;

  Color colorBarraDark = Colors.black38;
  Color colorBarraLight = Colors.teal[900];

  ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    splashColor: Colors.white60,
    primarySwatch: Colors.teal,
    primaryColor: Colors.teal,
    cardTheme: CardTheme(color: Colors.yellow[50]),
    appBarTheme: AppBarTheme(
        elevation: 0, brightness: Brightness.light, color: Colors.transparent),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.red[400]),
  );

  ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      splashColor: Colors.black87,
      primarySwatch: Colors.teal,
      primaryColor: Colors.teal,
      appBarTheme: AppBarTheme(
          elevation: 0, brightness: Brightness.dark, color: Colors.transparent),
      cardTheme: CardTheme(color: Color.fromRGBO(30, 30, 30, 1)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.black87.withRed(50)));

  @action
  void changeTheme(String theme) {
    switch (theme) {
      case "light":
        setLightTheme();
        break;

      case "dark":
        setDarkTheme();
        break;

      default:
        setSystemTheme();

        if (WidgetsBinding.instance.window.platformBrightness ==
            Brightness.light) {
          colorBarra = colorBarraLight;
          colorBarNewTask = colorBarNewTaskLight;
        } else {
          colorBarra = colorBarraDark;
          colorBarNewTask = colorBarNewTaskDark;
        }
        break;
    }
  }

  void setSystemTheme() {
    themeMode = ThemeMode.system;
    valorSystem = "system";
    valorLight = "";
    valorDark = "";
  }

  void setLightTheme() {
    colorBarra = colorBarraLight;
    colorBarNewTask = colorBarNewTaskLight;
    themeMode = ThemeMode.light;
    valorSystem = "";
    valorLight = "light";
    valorDark = "";
  }

  void setDarkTheme() {
    colorBarra = colorBarraDark;
    colorBarNewTask = colorBarNewTaskDark;
    themeMode = ThemeMode.dark;
    valorSystem = "";
    valorLight = "";
    valorDark = "dark";
  }
}
