import 'dart:ui';

import 'package:flutter/cupertino.dart';


class Colors {

  const Colors();

  static const Color loginGradientStart    = const Color.fromRGBO(255, 191, 0, 100);
  static const Color loginGradientEnd      = const Color.fromRGBO(200, 20, 60, 100);
  static const Color loginGradientbuttun   = const Color.fromRGBO(10, 10, 10, 100);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd, loginGradientbuttun],
    stops:  const [0.0, 1.0],

    begin:  Alignment.topCenter,
    end:    Alignment.bottomCenter,

  );

}