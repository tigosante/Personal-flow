import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:personalflow/core/model/simples/model.dart';
import 'package:personalflow/core/model/simples/simple_repository.interface.dart';
import 'package:personalflow/core/view/view_simples.dart';

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
  void getList() {
    tarefaSimples = repository.getTarefas().asObservable();
  }

  @action
  dialogTarefa(BuildContext context, dynamic data, double tamanhoTela) =>
      ViewSimples.returnDialogTarefa(context, data, tamanhoTela);
}
