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
    final string = 'themeMode: ${themeMode.toString()}';
    return '{$string}';
  }
}
