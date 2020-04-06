import 'package:flutter_modular/flutter_modular.dart';

import 'barra_pesquisa.dart';
import 'barra_pesquisa_controller.dart';

class BarraPesquisaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => BarraPesquisaController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => BarraPesquisa()),
      ];

  static Inject get to => Inject<BarraPesquisaModule>.of();
}
