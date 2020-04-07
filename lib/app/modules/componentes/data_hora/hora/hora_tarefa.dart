import 'package:flutter/material.dart';

class HoraTarefa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double tamanhoTela = MediaQuery.of(context).size.width;

    return Card(
      elevation: 0,
      color: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tamanhoTela * 0.05)),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.only(
            top: tamanhoTela * 0.02,
            left: tamanhoTela * 0.01,
            right: tamanhoTela * 0.01,
            bottom: tamanhoTela * 0.02,
          ),
          child: Text(
            "00:00",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: tamanhoTela * 0.035),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
