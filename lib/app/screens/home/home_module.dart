import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/componentes/barra_pesquisa/barra_pesquisa_controller.dart';
import 'package:personalflow/app/componentes/icone_user/icone_user_controller.dart';
import 'package:personalflow/app/screens/home/pages/composta/composta_controller.dart';
import 'package:personalflow/app/screens/home/pages/simples/simples_controller.dart';
import 'package:personalflow/core/model/composta/composed_repository.dart';
import 'package:personalflow/core/model/composta/composed_repository.interface.dart';
import 'package:personalflow/core/model/simples/simple_repository.dart';
import 'package:personalflow/core/model/simples/simple_repository.interface.dart';

import '../nova_tarefa/nova_tarefa_controller.dart';
import '../nova_tarefa/nova_tarefa_page.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind((i) => IconUserController()),
        Bind((i) => NovaTarefaController()),
        Bind((i) => BarraPesquisaController()),
        Bind((i) => SimplesController(i.get())),
        Bind((i) => CompostaController(i.get())),
        Bind<ISimpleRepository>(
            (i) => TarefaSimplesRepository(Firestore.instance)),
        Bind<IComposedRepository>(
            (i) => TarefaCompostaRepository(Firestore.instance)),
      ];

  @override
  List<Router> get routers => [
        Router("/", child: (_, args) => HomePage()),
        Router("/adicionar_tarefa",
            child: (_, args) => NovaTarefaPage(),
            transition: TransitionType.rightToLeft),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
