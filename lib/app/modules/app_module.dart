import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:personalflow/app/app_widget.dart';
import 'package:personalflow/app/controllers/app_controller.dart';
import 'package:personalflow/core/controllers/auth_controller.dart';
import 'package:personalflow/core/interfaces/composed_repository.interface.dart';
import 'package:personalflow/core/interfaces/email_interface.dart';
import 'package:personalflow/core/interfaces/google_interface.dart';
import 'package:personalflow/core/interfaces/simple_repository.interface.dart';
import 'package:personalflow/core/repositorys/composed_repository.dart';
import 'package:personalflow/core/repositorys/email_repository.dart';
import 'package:personalflow/core/repositorys/google_repository.dart';
import 'package:personalflow/core/repositorys/simple_repository.dart';
import 'package:personalflow/pages/home/controllers/home_controller.dart';
import 'package:personalflow/pages/home/modules/home_module.dart';
import 'package:personalflow/pages/home/pages/composta/controllers/composta_controller.dart';
import 'package:personalflow/pages/home/pages/simples/controllers/simples_controller.dart';
import 'package:personalflow/pages/login/controllers/login_controller.dart';
import 'package:personalflow/pages/login/modules/login_module.dart';
import 'package:personalflow/pages/nova_tarefa/controllers/nova_tarefa_controller.dart';
import 'package:personalflow/pages/nova_tarefa/modules/nova_tarefa_module.dart';
import 'package:personalflow/pages/splash/splash_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => HomeController()),
        Bind((i) => LoginController()),
        Bind((i) => AuthController()),
        Bind((i) => NovaTarefaController()),
        Bind((i) => SimplesController(i.get())),
        Bind<ISimpleRepository>(
            (i) => TarefaSimplesRepository(Firestore.instance)),
        Bind<EmailInterface>((i) => LoginEmailRepository()),
        Bind<GoogleInterface>((i) => LoginGoogleRepository()),
        Bind((i) => CompostaController(i.get())),
        Bind<IComposedRepository>(
            (i) => TarefaCompostaRepository(Firestore.instance)),
      ];

  @override
  List<Router> get routers => [
        Router("/", child: (_, args) => SplashPage()),
        Router("/", module: HomeModule()),
        Router("/login", module: LoginModule()),
        Router("/adicionar_tarefa", module: NovaTarefaModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
