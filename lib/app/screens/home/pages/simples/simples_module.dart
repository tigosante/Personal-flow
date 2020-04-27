import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/screens/home/pages/simples/simples_controller.dart';
import 'package:personalflow/app/screens/home/pages/simples/simples_page.dart';
import 'package:personalflow/core/model/simples/simple_repository.dart';
import 'package:personalflow/core/model/simples/simple_repository.interface.dart';

class SimplesModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SimplesController(i.get())),
        Bind<ISimpleRepository>(
            (i) => TarefaSimplesRepository(Firestore.instance)),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => SimplesPage()),
      ];

  static Inject get to => Inject<SimplesModule>.of();
}
