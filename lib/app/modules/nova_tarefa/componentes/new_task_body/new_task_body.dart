import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:personalflow/app/modules/nova_tarefa/componentes/new_task_composed/new_task_composed.dart';
import 'package:personalflow/app/modules/nova_tarefa/componentes/new_task_simple/new_task_simple.dart';
import '../../nova_tarefa_controller.dart';

class NewTaskBody extends StatefulWidget {
  @override
  _NewTaskBodyState createState() => _NewTaskBodyState();
}

class _NewTaskBodyState extends State<NewTaskBody> {
  final controller = Modular.get<NovaTarefaController>();

  @override
  Widget build(BuildContext context) => PageView(
      controller: controller.pageController,
      children: <Widget>[NewTaskComposed(), NewTaskSimple()],
      onPageChanged: controller.changeTask);
}
