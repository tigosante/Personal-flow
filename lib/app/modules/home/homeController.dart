import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:personal_flow/api/DataBaseUrl.dart';
import 'package:personal_flow/app/modules/home/interfaces/DataTransformInterface.dart';
import 'package:personal_flow/services/interfaces/RequestHttpInterface.dart';

part 'homeController.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  RequestHttpInterface _request = Modular.get<RequestHttpInterface>();
  DataTransformInterface _data = Modular.get<DataTransformInterface>();

  static const _SIMPLE_TASK = "simplesTask.json";

  get tasks => _request.get(DataBaseUrl.URL + _SIMPLE_TASK);

  Widget getAllTasks(AsyncSnapshot snapshot) => snapshot.hasData
      ? _data.loadListview(snapshot)
      : CircularProgressIndicator();
}
