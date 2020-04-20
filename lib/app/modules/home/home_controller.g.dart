// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$tarefaSimplesAtom = Atom(name: '_HomeControllerBase.tarefaSimples');

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

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic getList() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction();
    try {
      return super.getList();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void navigationNewTask() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction();
    try {
      return super.navigationNewTask();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'tarefaSimples: ${tarefaSimples.toString()}';
    return '{$string}';
  }
}
