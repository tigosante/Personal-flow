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
  Color colorBarraPesquisa = Color.fromRGBO(255, 255, 255, 0.6);

  @observable
  Color colorTarefa = Colors.black;

  @observable
  Color colorBarNewTask = Colors.indigo[900];

  Color colorBarNewTaskDark = Colors.black38;
  Color colorBarNewTaskLight = Colors.indigo[900];

  Color colorTarefaDark = Colors.white;
  Color colorTarefaLight = Colors.black;

  Color colorBarraPesquisaDark = Color.fromRGBO(255, 255, 255, 0.1);
  Color colorBarraPesquisaLight = Color.fromRGBO(255, 255, 255, 0.6);

  Color colorBarraDark = Colors.black38;
  Color colorBarraLight = Colors.teal[900];

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    splashColor: Colors.white60,
    primarySwatch: Colors.purple,
    primaryColor: Colors.purple,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.purple),
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    splashColor: Colors.black87,
    primarySwatch: Colors.deepPurple,
    primaryColor: Colors.deepPurple,
    cardTheme: CardTheme(color: Color.fromRGBO(30, 30, 30, 1)),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.deepPurple),
  );

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
          colorBarraPesquisa = colorBarraPesquisaLight;
          colorTarefa = colorTarefaLight;
          colorBarNewTask = colorBarNewTaskLight;
        } else {
          colorBarra = colorBarraDark;
          colorBarraPesquisa = colorBarraPesquisaDark;
          colorTarefa = colorTarefaDark;
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
    colorBarraPesquisa = colorBarraPesquisaLight;
    colorTarefa = colorTarefaLight;
    colorBarNewTask = colorBarNewTaskLight;
    themeMode = ThemeMode.light;
    valorSystem = "";
    valorLight = "light";
    valorDark = "";
  }

  void setDarkTheme() {
    colorBarra = colorBarraDark;
    colorBarraPesquisa = colorBarraPesquisaDark;
    colorTarefa = colorTarefaDark;
    colorBarNewTask = colorBarNewTaskDark;
    themeMode = ThemeMode.dark;
    valorSystem = "";
    valorLight = "";
    valorDark = "dark";
  }
}
