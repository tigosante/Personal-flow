import 'package:personalflow/app/modules/componentes/barra_pesquisa/barra_pesquisa_controller.dart';
import 'package:personalflow/app/modules/componentes/icone_user/icone_user_controller.dart';
import 'package:personalflow/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/modules/home/home_page.dart';

import '../nova_tarefa/nova_tarefa_controller.dart';
import '../nova_tarefa/nova_tarefa_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind((i) => IconUserController()),
        Bind((i) => BarraPesquisaController()),
        Bind((i) => NovaTarefaController()),
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
