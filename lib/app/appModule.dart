import 'appController.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/app/appWidget.dart';
import 'package:personal_flow/app/modules/home/homeModule.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [Bind((i) => AppController())];

  @override
  List<Router> get routers =>
      [Router(Modular.initialRoute, module: HomeModule())];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
