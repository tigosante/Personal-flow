import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/screens/home/pages/simples/simples_controller.dart';
import 'package:personalflow/app/screens/home/pages/simples/simples_page.dart';
import 'package:personalflow/core/interfaces/simple_repository.interface.dart';
import 'package:personalflow/core/repositorys/simple_repository.dart';

class SimplesModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SimplesController(i.get())),
        Bind<ISimpleRepository>(
            (i) => TarefaSimplesRepository(Firestore.instance)),
      ];

  @override
  List<Router> get routers => [
        Router("/simples", child: (_, args) => SimplesPage()),
      ];

  static Inject get to => Inject<SimplesModule>.of();
}
