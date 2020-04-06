import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  @observable
  ThemeMode themeMode = ThemeMode.system;

  @observable
  Color colorBarra = Color.fromRGBO(75, 0, 130, 0.7);

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    splashColor: Colors.white60,
    primarySwatch: Colors.purple,
    primaryColor: Colors.purple,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.purple[50],
      brightness: Brightness.light,
    ),
    cardTheme: CardTheme(
      color: Color.fromRGBO(238, 215, 255, 1),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.purple,
    ),
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    splashColor: Colors.black87,
    primarySwatch: Colors.deepPurple,
    primaryColor: Colors.deepPurple,
    appBarTheme: AppBarTheme(
      elevation: 1,
      color: Color.fromRGBO(52, 52, 52, 1),
      brightness: Brightness.dark,
    ),
    cardTheme: CardTheme(
      color: Color.fromRGBO(70, 70, 70, 1),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple,
    ),
  );

  @action
  void changeTheme(String theme) {
    switch (theme) {
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.light;
    }
  }
}
