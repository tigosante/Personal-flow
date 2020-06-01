import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/core/interfaces/composed_repository.interface.dart';
import 'package:personalflow/core/repositorys/composed_repository.dart';

import 'composta_controller.dart';
import 'composta_page.dart';

class CompostaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => CompostaController(i.get())),
        Bind<IComposedRepository>(
            (i) => TarefaCompostaRepository(Firestore.instance)),
      ];

  @override
  List<Router> get routers => [
        Router("/composta", child: (_, args) => CompostaPage()),
      ];

  static Inject get to => Inject<CompostaModule>.of();
}
