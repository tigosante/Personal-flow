// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simples_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SimplesController on _SimplesControllerBase, Store {
  final _$telaAtualAtom = Atom(name: '_SimplesControllerBase.telaAtual');

  @override
  int get telaAtual {
    _$telaAtualAtom.context.enforceReadPolicy(_$telaAtualAtom);
    _$telaAtualAtom.reportObserved();
    return super.telaAtual;
  }

  @override
  set telaAtual(int value) {
    _$telaAtualAtom.context.conditionallyRunInAction(() {
      super.telaAtual = value;
      _$telaAtualAtom.reportChanged();
    }, _$telaAtualAtom, name: '${_$telaAtualAtom.name}_set');
  }

  final _$tarefaSimplesAtom =
      Atom(name: '_SimplesControllerBase.tarefaSimples');

  @override
  ObservableStream<List<ModelTarefaSimples>> get tarefaSimples {
    _$tarefaSimplesAtom.context.enforceReadPolicy(_$tarefaSimplesAtom);
    _$tarefaSimplesAtom.reportObserved();
    return super.tarefaSimples;
  }

  @override
  set tarefaSimples(ObservableStream<List<ModelTarefaSimples>> value) {
    _$tarefaSimplesAtom.context.conditionallyRunInAction(() {
      super.tarefaSimples = value;
      _$tarefaSimplesAtom.reportChanged();
    }, _$tarefaSimplesAtom, name: '${_$tarefaSimplesAtom.name}_set');
  }

  final _$_SimplesControllerBaseActionController =
      ActionController(name: '_SimplesControllerBase');

  @override
  void getList() {
    final _$actionInfo = _$_SimplesControllerBaseActionController.startAction();
    try {
      return super.getList();
    } finally {
      _$_SimplesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic dialogTarefa(BuildContext context, dynamic data, double tamanhoTela) {
    final _$actionInfo = _$_SimplesControllerBaseActionController.startAction();
    try {
      return super.dialogTarefa(context, data, tamanhoTela);
    } finally {
      _$_SimplesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'telaAtual: ${telaAtual.toString()},tarefaSimples: ${tarefaSimples.toString()}';
    return '{$string}';
  }
}
