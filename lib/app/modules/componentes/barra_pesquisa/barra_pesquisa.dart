import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'barra_pesquisa_controller.dart';

class BarraPesquisa extends StatelessWidget {
  final controller = Modular.get<BarraPesquisaController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(255, 255, 255, 0.2),
      child: Container(
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.add,
            ),
          ),
        ),
      ),
    );
  }
}
