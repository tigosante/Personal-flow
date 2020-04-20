import 'package:mobx/mobx.dart';
import 'package:personalflow/app/model/simples/model.dart';
import 'package:personalflow/app/model/simples/simple_repository.interface.dart';

part 'simples_controller.g.dart';

class SimplesController = _SimplesControllerBase with _$SimplesController;

abstract class _SimplesControllerBase with Store {
  final ISimpleRepository repository;

  _SimplesControllerBase(ISimpleRepository this.repository) {
    getList();
  }

  @observable
  int telaAtual = 0;

  @observable
  ObservableStream<List<ModelTarefaSimples>> tarefaSimples;

  @action
  getList() {
    tarefaSimples = repository.getTarefas().asObservable();
  }
}
