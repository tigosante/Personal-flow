import 'package:flutter/material.dart';

import 'subtarefa.dart';

class BodyComposta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [0, 0].map((_) {
        return Subtarefa();
      }).toList(),
    );
  }
}
