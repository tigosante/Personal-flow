// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barra_pesquisa_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BarraPesquisaController on _BarraPesquisaControllerBase, Store {
  final _$iconBarraAtom = Atom(name: '_BarraPesquisaControllerBase.iconBarra');

  @override
  Widget get iconBarra {
    _$iconBarraAtom.context.enforceReadPolicy(_$iconBarraAtom);
    _$iconBarraAtom.reportObserved();
    return super.iconBarra;
  }

  @override
  set iconBarra(Widget value) {
    _$iconBarraAtom.context.conditionallyRunInAction(() {
      super.iconBarra = value;
      _$iconBarraAtom.reportChanged();
    }, _$iconBarraAtom, name: '${_$iconBarraAtom.name}_set');
  }

  @override
  String toString() {
    final string = 'iconBarra: ${iconBarra.toString()}';
    return '{$string}';
  }
}
