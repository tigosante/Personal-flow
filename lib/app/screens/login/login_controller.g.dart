// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$controllerEmailAtom =
      Atom(name: '_LoginControllerBase.controllerEmail');

  @override
  TextEditingController get controllerEmail {
    _$controllerEmailAtom.context.enforceReadPolicy(_$controllerEmailAtom);
    _$controllerEmailAtom.reportObserved();
    return super.controllerEmail;
  }

  @override
  set controllerEmail(TextEditingController value) {
    _$controllerEmailAtom.context.conditionallyRunInAction(() {
      super.controllerEmail = value;
      _$controllerEmailAtom.reportChanged();
    }, _$controllerEmailAtom, name: '${_$controllerEmailAtom.name}_set');
  }

  final _$controllerSenhaEmailAtom =
      Atom(name: '_LoginControllerBase.controllerSenhaEmail');

  @override
  TextEditingController get controllerSenhaEmail {
    _$controllerSenhaEmailAtom.context
        .enforceReadPolicy(_$controllerSenhaEmailAtom);
    _$controllerSenhaEmailAtom.reportObserved();
    return super.controllerSenhaEmail;
  }

  @override
  set controllerSenhaEmail(TextEditingController value) {
    _$controllerSenhaEmailAtom.context.conditionallyRunInAction(() {
      super.controllerSenhaEmail = value;
      _$controllerSenhaEmailAtom.reportChanged();
    }, _$controllerSenhaEmailAtom,
        name: '${_$controllerSenhaEmailAtom.name}_set');
  }

  final _$loginWithAsyncAction = AsyncAction('loginWith');

  @override
  Future<void> loginWith(String service) {
    return _$loginWithAsyncAction.run(() => super.loginWith(service));
  }

  final _$loginWithEmilAsyncAction = AsyncAction('loginWithEmil');

  @override
  Future<void> loginWithEmil() {
    return _$loginWithEmilAsyncAction.run(() => super.loginWithEmil());
  }

  final _$logOutAsyncAction = AsyncAction('logOut');

  @override
  Future<dynamic> logOut() {
    return _$logOutAsyncAction.run(() => super.logOut());
  }

  @override
  String toString() {
    final string =
        'controllerEmail: ${controllerEmail.toString()},controllerSenhaEmail: ${controllerSenhaEmail.toString()}';
    return '{$string}';
  }
}
