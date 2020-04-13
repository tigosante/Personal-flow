// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nova_tarefa_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NovaTarefaController on _NovaTarefaControllerBase, Store {
  final _$selectValue0Atom =
      Atom(name: '_NovaTarefaControllerBase.selectValue0');

  @override
  bool get selectValue0 {
    _$selectValue0Atom.context.enforceReadPolicy(_$selectValue0Atom);
    _$selectValue0Atom.reportObserved();
    return super.selectValue0;
  }

  @override
  set selectValue0(bool value) {
    _$selectValue0Atom.context.conditionallyRunInAction(() {
      super.selectValue0 = value;
      _$selectValue0Atom.reportChanged();
    }, _$selectValue0Atom, name: '${_$selectValue0Atom.name}_set');
  }

  final _$selectValue1Atom =
      Atom(name: '_NovaTarefaControllerBase.selectValue1');

  @override
  bool get selectValue1 {
    _$selectValue1Atom.context.enforceReadPolicy(_$selectValue1Atom);
    _$selectValue1Atom.reportObserved();
    return super.selectValue1;
  }

  @override
  set selectValue1(bool value) {
    _$selectValue1Atom.context.conditionallyRunInAction(() {
      super.selectValue1 = value;
      _$selectValue1Atom.reportChanged();
    }, _$selectValue1Atom, name: '${_$selectValue1Atom.name}_set');
  }

  final _$colorItemSelect0Atom =
      Atom(name: '_NovaTarefaControllerBase.colorItemSelect0');

  @override
  Color get colorItemSelect0 {
    _$colorItemSelect0Atom.context.enforceReadPolicy(_$colorItemSelect0Atom);
    _$colorItemSelect0Atom.reportObserved();
    return super.colorItemSelect0;
  }

  @override
  set colorItemSelect0(Color value) {
    _$colorItemSelect0Atom.context.conditionallyRunInAction(() {
      super.colorItemSelect0 = value;
      _$colorItemSelect0Atom.reportChanged();
    }, _$colorItemSelect0Atom, name: '${_$colorItemSelect0Atom.name}_set');
  }

  final _$colorItemSelect1Atom =
      Atom(name: '_NovaTarefaControllerBase.colorItemSelect1');

  @override
  Color get colorItemSelect1 {
    _$colorItemSelect1Atom.context.enforceReadPolicy(_$colorItemSelect1Atom);
    _$colorItemSelect1Atom.reportObserved();
    return super.colorItemSelect1;
  }

  @override
  set colorItemSelect1(Color value) {
    _$colorItemSelect1Atom.context.conditionallyRunInAction(() {
      super.colorItemSelect1 = value;
      _$colorItemSelect1Atom.reportChanged();
    }, _$colorItemSelect1Atom, name: '${_$colorItemSelect1Atom.name}_set');
  }

  final _$colorText0Atom = Atom(name: '_NovaTarefaControllerBase.colorText0');

  @override
  Color get colorText0 {
    _$colorText0Atom.context.enforceReadPolicy(_$colorText0Atom);
    _$colorText0Atom.reportObserved();
    return super.colorText0;
  }

  @override
  set colorText0(Color value) {
    _$colorText0Atom.context.conditionallyRunInAction(() {
      super.colorText0 = value;
      _$colorText0Atom.reportChanged();
    }, _$colorText0Atom, name: '${_$colorText0Atom.name}_set');
  }

  final _$colorText1Atom = Atom(name: '_NovaTarefaControllerBase.colorText1');

  @override
  Color get colorText1 {
    _$colorText1Atom.context.enforceReadPolicy(_$colorText1Atom);
    _$colorText1Atom.reportObserved();
    return super.colorText1;
  }

  @override
  set colorText1(Color value) {
    _$colorText1Atom.context.conditionallyRunInAction(() {
      super.colorText1 = value;
      _$colorText1Atom.reportChanged();
    }, _$colorText1Atom, name: '${_$colorText1Atom.name}_set');
  }

  final _$indexPageAtom = Atom(name: '_NovaTarefaControllerBase.indexPage');

  @override
  int get indexPage {
    _$indexPageAtom.context.enforceReadPolicy(_$indexPageAtom);
    _$indexPageAtom.reportObserved();
    return super.indexPage;
  }

  @override
  set indexPage(int value) {
    _$indexPageAtom.context.conditionallyRunInAction(() {
      super.indexPage = value;
      _$indexPageAtom.reportChanged();
    }, _$indexPageAtom, name: '${_$indexPageAtom.name}_set');
  }

  final _$subtarefasAtom = Atom(name: '_NovaTarefaControllerBase.subtarefas');

  @override
  List<Subatarefas> get subtarefas {
    _$subtarefasAtom.context.enforceReadPolicy(_$subtarefasAtom);
    _$subtarefasAtom.reportObserved();
    return super.subtarefas;
  }

  @override
  set subtarefas(List<Subatarefas> value) {
    _$subtarefasAtom.context.conditionallyRunInAction(() {
      super.subtarefas = value;
      _$subtarefasAtom.reportChanged();
    }, _$subtarefasAtom, name: '${_$subtarefasAtom.name}_set');
  }

  final _$_NovaTarefaControllerBaseActionController =
      ActionController(name: '_NovaTarefaControllerBase');

  @override
  void changeTask(int index) {
    final _$actionInfo =
        _$_NovaTarefaControllerBaseActionController.startAction();
    try {
      return super.changeTask(index);
    } finally {
      _$_NovaTarefaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'selectValue0: ${selectValue0.toString()},selectValue1: ${selectValue1.toString()},colorItemSelect0: ${colorItemSelect0.toString()},colorItemSelect1: ${colorItemSelect1.toString()},colorText0: ${colorText0.toString()},colorText1: ${colorText1.toString()},indexPage: ${indexPage.toString()},subtarefas: ${subtarefas.toString()}';
    return '{$string}';
  }
}
