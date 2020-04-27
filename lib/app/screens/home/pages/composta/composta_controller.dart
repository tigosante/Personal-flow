import 'package:mobx/mobx.dart';
import 'package:personalflow/core/model/composta/composed_repository.interface.dart';
import 'package:personalflow/core/model/composta/model.dart';

part 'composta_controller.g.dart';

class CompostaController = _CompostaControllerBase with _$CompostaController;

abstract class _CompostaControllerBase with Store {
  final IComposedRepository repository;

  _CompostaControllerBase(IComposedRepository this.repository) {
    getList();
  }

  @observable
  int qntTarefas;

  @observable
  ObservableStream<List<ModelTarefaComposta>> tarefaComposta;

  @action
  void getList() {
    tarefaComposta = repository.getTarefas().asObservable();
  }

  // @action
  // dialogTarefa(BuildContext context, dynamic data, double tamanhoTela) =>
  // ViewSComposta.returnDialogTarefa(context, data, tamanhoTela);
}
