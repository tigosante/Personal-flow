import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

class AppBloc extends BlocBase{
  bool dark = false;

  final StreamController<bool> _theme$ = StreamController<bool>();
  Stream<bool> get theme=> _theme$.stream;

  @override
  dispose() {
    _theme$.close();
    super.dispose();
  }
}