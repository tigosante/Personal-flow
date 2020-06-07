// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'composta_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CompostaController on _CompostaControllerBase, Store {
  final _$qntTarefasAtom = Atom(name: '_CompostaControllerBase.qntTarefas');

  @override
  int get qntTarefas {
    _$qntTarefasAtom.context.enforceReadPolicy(_$qntTarefasAtom);
    _$qntTarefasAtom.reportObserved();
    return super.qntTarefas;
  }

  @override
  set qntTarefas(int value) {
    _$qntTarefasAtom.context.conditionallyRunInAction(() {
      super.qntTarefas = value;
      _$qntTarefasAtom.reportChanged();
    }, _$qntTarefasAtom, name: '${_$qntTarefasAtom.name}_set');
  }

  final _$tarefaCompostaAtom =
      Atom(name: '_CompostaControllerBase.tarefaComposta');

  @override
  ObservableStream<List<ModelTarefaComposta>> get tarefaComposta {
    _$tarefaCompostaAtom.context.enforceReadPolicy(_$tarefaCompostaAtom);
    _$tarefaCompostaAtom.reportObserved();
    return super.tarefaComposta;
  }

  @override
  set tarefaComposta(ObservableStream<List<ModelTarefaComposta>> value) {
    _$tarefaCompostaAtom.context.conditionallyRunInAction(() {
      super.tarefaComposta = value;
      _$tarefaCompostaAtom.reportChanged();
    }, _$tarefaCompostaAtom, name: '${_$tarefaCompostaAtom.name}_set');
  }

  final _$_CompostaControllerBaseActionController =
      ActionController(name: '_CompostaControllerBase');

  @override
  void getList() {
    final _$actionInfo =
        _$_CompostaControllerBaseActionController.startAction();
    try {
      return super.getList();
    } finally {
      _$_CompostaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'qntTarefas: ${qntTarefas.toString()},tarefaComposta: ${tarefaComposta.toString()}';
    return '{$string}';
  }
}
