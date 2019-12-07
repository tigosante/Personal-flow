import 'package:flutter/material.dart';

List<Widget> geradorNovaComposta(quantidade, componente) {
  return List<Widget>.generate(quantidade, (_) => componente);
}