import 'package:flutter/material.dart';

List<Widget> geradorNovaComposta(int quantidade, Widget componente) {
  return List<Widget>.generate(quantidade, (_) => componente);
}