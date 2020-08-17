import 'package:personal_flow/services/interfaces/RequestHttpInterface.dart';
import 'package:personal_flow/services/requests/RequestHttp.dart';

import 'homeController.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'HomePage.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind<RequestHttpInterface>((i) => RequestHttp()),
      ];

  @override
  List<Router> get routers =>
      [Router(Modular.initialRoute, child: (_, args) => HomePage())];

  static Inject get to => Inject<HomeModule>.of();
}
