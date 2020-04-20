import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:personalflow/app/model/model.dart';
import 'package:personalflow/app/model/repository.interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final IRepository repository;

  _HomeControllerBase(IRepository this.repository) {
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
