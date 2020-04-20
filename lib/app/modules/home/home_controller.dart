import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:personalflow/app/model/simples/model.dart';
import 'package:personalflow/app/model/simples/simple_repository.interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final ISimpleRepository repository;

  _HomeControllerBase(ISimpleRepository this.repository) {
    getList();
  }

  @observable
  ObservableStream<List<ModelTarefaSimples>> tarefaSimples;

  @action
  getList() {
    tarefaSimples = repository.getTarefas().asObservable();
  }

  @action
  void navigationNewTask() => Modular.to.pushNamed("/adicionar_tarefa");
}
