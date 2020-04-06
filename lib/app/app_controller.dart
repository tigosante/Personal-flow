import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  @observable
  ThemeMode themeMode = ThemeMode.system;

  ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.purple,
    primaryColor: Colors.purple,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.purple[50],
      brightness: Brightness.light,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.purple,
    ),
  );

  ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    primaryColor: Colors.deepPurple,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.deepPurple,
      brightness: Brightness.dark,
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
