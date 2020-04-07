// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppControllerBase, Store {
  final _$themeModeAtom = Atom(name: '_AppControllerBase.themeMode');

  @override
  ThemeMode get themeMode {
    _$themeModeAtom.context.enforceReadPolicy(_$themeModeAtom);
    _$themeModeAtom.reportObserved();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode value) {
    _$themeModeAtom.context.conditionallyRunInAction(() {
      super.themeMode = value;
      _$themeModeAtom.reportChanged();
    }, _$themeModeAtom, name: '${_$themeModeAtom.name}_set');
  }

  final _$valorSystemAtom = Atom(name: '_AppControllerBase.valorSystem');

  @override
  String get valorSystem {
    _$valorSystemAtom.context.enforceReadPolicy(_$valorSystemAtom);
    _$valorSystemAtom.reportObserved();
    return super.valorSystem;
  }

  @override
  set valorSystem(String value) {
    _$valorSystemAtom.context.conditionallyRunInAction(() {
      super.valorSystem = value;
      _$valorSystemAtom.reportChanged();
    }, _$valorSystemAtom, name: '${_$valorSystemAtom.name}_set');
  }

  final _$valorLightAtom = Atom(name: '_AppControllerBase.valorLight');

  @override
  String get valorLight {
    _$valorLightAtom.context.enforceReadPolicy(_$valorLightAtom);
    _$valorLightAtom.reportObserved();
    return super.valorLight;
  }

  @override
  set valorLight(String value) {
    _$valorLightAtom.context.conditionallyRunInAction(() {
      super.valorLight = value;
      _$valorLightAtom.reportChanged();
    }, _$valorLightAtom, name: '${_$valorLightAtom.name}_set');
  }

  final _$valorDarkAtom = Atom(name: '_AppControllerBase.valorDark');

  @override
  String get valorDark {
    _$valorDarkAtom.context.enforceReadPolicy(_$valorDarkAtom);
    _$valorDarkAtom.reportObserved();
    return super.valorDark;
  }

  @override
  set valorDark(String value) {
    _$valorDarkAtom.context.conditionallyRunInAction(() {
      super.valorDark = value;
      _$valorDarkAtom.reportChanged();
    }, _$valorDarkAtom, name: '${_$valorDarkAtom.name}_set');
  }

  final _$colorBarraAtom = Atom(name: '_AppControllerBase.colorBarra');

  @override
  Color get colorBarra {
    _$colorBarraAtom.context.enforceReadPolicy(_$colorBarraAtom);
    _$colorBarraAtom.reportObserved();
    return super.colorBarra;
  }

  @override
  set colorBarra(Color value) {
    _$colorBarraAtom.context.conditionallyRunInAction(() {
      super.colorBarra = value;
      _$colorBarraAtom.reportChanged();
    }, _$colorBarraAtom, name: '${_$colorBarraAtom.name}_set');
  }

  final _$_AppControllerBaseActionController =
      ActionController(name: '_AppControllerBase');

  @override
  void changeTheme(String theme) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction();
    try {
      return super.changeTheme(theme);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'themeMode: ${themeMode.toString()},valorSystem: ${valorSystem.toString()},valorLight: ${valorLight.toString()},valorDark: ${valorDark.toString()},colorBarra: ${colorBarra.toString()}';
    return '{$string}';
  }
}
