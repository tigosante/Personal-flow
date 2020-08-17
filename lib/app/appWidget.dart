import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personal_flow/app/appController.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<AppController>();

    return MaterialApp(
      title: 'Personal Flow',
      theme: controller.themeData,
      initialRoute: controller.initialRoute,
      navigatorKey: Modular.navigatorKey,
      onGenerateRoute: Modular.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
