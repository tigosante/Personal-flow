// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$telaAtualAtom = Atom(name: '_HomeControllerBase.telaAtual');

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

  final _$pagesAtom = Atom(name: '_HomeControllerBase.pages');

  @override
  List<Pages> get pages {
    _$pagesAtom.context.enforceReadPolicy(_$pagesAtom);
    _$pagesAtom.reportObserved();
    return super.pages;
  }

  @override
  set pages(List<Pages> value) {
    _$pagesAtom.context.conditionallyRunInAction(() {
      super.pages = value;
      _$pagesAtom.reportChanged();
    }, _$pagesAtom, name: '${_$pagesAtom.name}_set');
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void changeTela(int tela) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction();
    try {
      return super.changeTela(tela);
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
    final string =
        'telaAtual: ${telaAtual.toString()},pages: ${pages.toString()}';
    return '{$string}';
  }
}
