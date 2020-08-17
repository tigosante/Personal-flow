import 'package:mobx/mobx.dart';

part 'homeController.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  int value = 0;
}
