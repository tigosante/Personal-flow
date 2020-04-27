import 'package:personalflow/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:personalflow/app/app_widget.dart';
import 'package:personalflow/app/screens/home/home_controller.dart';
import 'package:personalflow/app/screens/home/home_module.dart';
import 'package:personalflow/app/screens/login/login_controller.dart';
import 'package:personalflow/app/screens/login/login_module.dart';
import 'package:personalflow/app/screens/nova_tarefa/nova_tarefa_controller.dart';
import 'package:personalflow/app/screens/nova_tarefa/nova_tarefa_module.dart';
import 'package:personalflow/app/screens/splash/splash_page.dart';
import 'package:personalflow/core/controller/login/auth_controller.dart';
import 'package:personalflow/core/model/login/login_repository.dart';
import 'package:personalflow/core/model/login/login_repository_interface.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => HomeController()),
        Bind((i) => LoginController()),
        Bind((i) => NovaTarefaController()),
        Bind((i) => AuthController()),
        Bind<ILoginRepository>((i) => LoginRepository()),
      ];

  @override
  List<Router> get routers => [
        Router("/", child: (_, args) => SplashPage()),
        Router("/home", module: HomeModule()),
        Router("/login", module: LoginModule()),
        Router("/adicionar_tarefa", module: NovaTarefaModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
