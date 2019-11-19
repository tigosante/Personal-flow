import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:personal_flow/app/screens/home/components/card_struct.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Personal Flow",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale("pt", "BR")],
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      buttonColor: Colors.blue,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        buttonColor: Colors.blue
      ),
      bottomAppBarColor: Colors.white,
      primaryColorBrightness: Brightness.dark,
      fontFamily: 'Orkney-medium',
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        buttonColor: Colors.blue,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        primarySwatch: Colors.blue,
        fontFamily: 'Orkney-medium'
      ),

      home: CardStruct(),
    );
  }
}
