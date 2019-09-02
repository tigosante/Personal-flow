import 'dart:ui';

import 'package:flutter/cupertino.dart';


class Colors {

  const Colors();

  static const Color corLight     = const Color.fromRGBO(255, 255, 0, 100);
  static const Color corDark      = const Color.fromRGBO(206, 17, 17, 100);
  static const Color corBotao     = const Color.fromRGBO(255, 255, 0, 100);

  static const cores = const LinearGradient(
    colors: const [corLight, corDark, corBotao],
    stops:  const [0.0, 1.0],

    begin:  Alignment.topCenter,
    end:    Alignment.bottomCenter,

  );

}