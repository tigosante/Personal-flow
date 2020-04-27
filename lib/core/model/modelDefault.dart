import 'package:flutter/material.dart';

class ModelDefault {
  static String dataTratada(DateTime data) {
    if (data != null) {
      return data
          .toString()
          .split(" ")
          .toList()[0]
          .split("-")
          .toList()
          .reversed
          .join("/");
    }
    return "";
  }

  static String horaTratada(TimeOfDay hora) {
    if (hora != null) {
      return hora.toString().split("TimeOfDay(")[1].split(")")[0];
    }
    return "";
  }
}
