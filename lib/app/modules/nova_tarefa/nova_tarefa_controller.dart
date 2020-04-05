import 'package:mobx/mobx.dart';

part 'nova_tarefa_controller.g.dart';

class NovaTarefaController = _NovaTarefaControllerBase
    with _$NovaTarefaController;

abstract class _NovaTarefaControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
