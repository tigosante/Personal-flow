import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../nova_tarefa_controller.dart';

class TabComposta extends StatelessWidget {
  TabComposta({Key key, this.tamanhoTela}) : super(key: key);

  final double tamanhoTela;
  final controller = Modular.get<NovaTarefaController>();

  @override
  Widget build(BuildContext context) => Observer(
      builder: (_) => ChoiceChip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(tamanhoTela * 0.02)),
          padding: EdgeInsets.all(tamanhoTela * 0.03),
          elevation: 0,
          label: Text("Tarefa Composta",
              style: TextStyle(
                  color: controller.colorText0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: tamanhoTela * 0.0035)),
          selected: controller.selectValue0,
          selectedColor: controller.colorItemSelect0,
          onSelected: (_) => controller.changeTask(0)));
}
