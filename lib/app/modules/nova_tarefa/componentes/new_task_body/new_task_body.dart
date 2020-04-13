import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../nova_tarefa_controller.dart';

class NewTaskBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<NovaTarefaController>();

    return Expanded(
        child: PageView.builder(
            itemCount: controller.items.length,
            scrollDirection: Axis.horizontal,
            controller: PageController(initialPage: 0),
            itemBuilder: (BuildContext _, int index) => Observer(
                builder: (_) => controller.items[controller.indexPage]),
            onPageChanged: controller.changeTask));
  }
}
