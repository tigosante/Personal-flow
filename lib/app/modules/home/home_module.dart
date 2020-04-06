import 'package:personalflow/app/modules/componentes/barra_pesquisa/barra_pesquisa_controller.dart';
import 'package:personalflow/app/modules/componentes/icone_user/icone_user_controller.dart';
import 'package:personalflow/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind((i) => IconUserController()),
        Bind((i) => BarraPesquisaController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
