// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$loadAtom = Atom(name: '_LoginControllerBase.load');

  @override
  bool get load {
    _$loadAtom.context.enforceReadPolicy(_$loadAtom);
    _$loadAtom.reportObserved();
    return super.load;
  }

  @override
  set load(bool value) {
    _$loadAtom.context.conditionallyRunInAction(() {
      super.load = value;
      _$loadAtom.reportChanged();
    }, _$loadAtom, name: '${_$loadAtom.name}_set');
  }

  final _$loginWithGoogleAsyncAction = AsyncAction('loginWithGoogle');

  @override
  Future<dynamic> loginWithGoogle() {
    return _$loginWithGoogleAsyncAction.run(() => super.loginWithGoogle());
  }

  final _$logOutAsyncAction = AsyncAction('logOut');

  @override
  Future<dynamic> logOut() {
    return _$logOutAsyncAction.run(() => super.logOut());
  }

  @override
  String toString() {
    final string = 'load: ${load.toString()}';
    return '{$string}';
  }
}
