import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../nova_tarefa_controller.dart';

class TabsNewTask extends StatelessWidget {
  TabsNewTask({Key key, this.tamanhoTela}) : super(key: key);

  final double tamanhoTela;
  final controller = Modular.get<NovaTarefaController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: tamanhoTela * 0.02, bottom: tamanhoTela * 0.02),
        child: Card(
            elevation: 0,
            color: Colors.indigo.withOpacity(0.1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(tamanhoTela * 0.1)),
            child: Container(
                padding: EdgeInsets.all(tamanhoTela * 0.01),
                width: tamanhoTela * 0.6,
                child: Observer(builder: (_) {
                  return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ChoiceChip(
                            label: Text("Composta",
                                style: TextStyle(
                                    color: controller.colorText0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: tamanhoTela * 0.0035)),
                            selected: controller.selectValue0,
                            selectedColor: controller.colorItemSelect0,
                            onSelected: (bool select) =>
                                controller.changeTask(0)),
                        ChoiceChip(
                            label: Text("Simples",
                                style: TextStyle(
                                    color: controller.colorText1,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: tamanhoTela * 0.0035)),
                            selected: controller.selectValue1,
                            selectedColor: controller.colorItemSelect1,
                            onSelected: (bool select) =>
                                controller.changeTask(1)),
                      ]);
                }))));
  }
}
