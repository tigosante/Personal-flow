import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:personal_flow/app/screens/home/home2.dart';
// import 'package:personal_flow/app/screens/home/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale("pt", "BR")],
      debugShowCheckedModeBanner: false,
      theme: 
      // new ThemeData.dark(),
      ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Orkney-medium'
      ),

      home: Home(),
    );
  }
}
