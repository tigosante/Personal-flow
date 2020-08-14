import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:personal_flow/api/DataBaseUrl.dart';
import 'package:personal_flow/services/interfaces/RequestHttpInterface.dart';

part 'homeController.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  static const _URL_SIMPLE_TASK = "simplesTask.json";

  void create(String value) => Modular.get<RequestHttpInterface>()
      .post((DataBaseUrl.URL + _URL_SIMPLE_TASK), body: _makeJson(value));

  String _makeJson(String value) => json.encode({"title": value});
}
