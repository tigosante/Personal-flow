import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    final controller = Modular.get<AppController>();

    return Observer(
        builder: (_) => MaterialApp(
            title: 'Personal Flow',
            theme: controller.lightTheme,
            darkTheme: controller.darkTheme,
            themeMode: controller.themeMode,
            initialRoute: '/',
            navigatorKey: Modular.navigatorKey,
            onGenerateRoute: Modular.generateRoute,
            debugShowCheckedModeBanner: false));
  }
}
