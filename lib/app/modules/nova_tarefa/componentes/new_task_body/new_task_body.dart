import 'package:flutter/material.dart';
import 'package:personalflow/app/modules/nova_tarefa/componentes/new_task_composed/new_task_composed.dart';
import 'package:personalflow/app/modules/nova_tarefa/componentes/new_task_simple/new_task_simple.dart';

class NewTaskBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;
    List<Widget> items = [
      NewTaskComposed(tamanhoTela: tamanhoTela),
      NewTaskSimple()
    ];

    return Expanded(
      child: PageView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        controller: PageController(initialPage: 0),
        itemBuilder: (BuildContext context, int index) => items[index],
        onPageChanged: (int index) {},
      ),
    );
  }
}
