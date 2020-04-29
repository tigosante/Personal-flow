import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import './widgets/bt_google/btn_login_google.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BtnLoginGoogle(),
            ],
          ),
        ),
        persistentFooterButtons: <Widget>[
          Text("Personal FLow"),
          IconButton(
            icon: Icon(EvaIcons.sun),
            onPressed: () {},
          )
        ],
      );
}
