import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/app/screens/graphic/graphic.dart';
import 'package:personal_flow/app/screens/home/components/card_struct.dart';
import 'package:personal_flow/app/shared/notification_widget.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List pages = [CardStruct(), NotificationWidget()];

    return Scaffold(
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Colors.blue[600],
        inactiveIconColor: Colors.blue[600],
        tabs: [
          TabData(iconData: Icons.playlist_add_check, title: "Tarefas"),
          TabData(iconData: Icons.poll, title: "Gráfico")
        ],
        onTabChangedListener: (position) {
          setState(() {
            _selectedIndex = position;
          });
        },
      ),
    );
  }
}
