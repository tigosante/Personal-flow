import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/app/screens/graphic/graphic.dart';
import 'package:personal_flow/app/screens/home/task_screen.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // BLOC
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // BLOC
    List pages = [TaskScreen(), Graphic()];

    return Scaffold(
      body: pages.elementAt(_selectedIndex),

      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        color: Colors.grey[200],
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.blue[600],

        // BLOC
        onTap: (tapPage){
          setState(() {
            _selectedIndex = tapPage;
          });
        },

        items: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.playlist_add_check,
              // BLOC
              color: _selectedIndex == 1 ? Colors.black : Colors.white,
            ),
          ),

          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: 
            Icon(
              Icons.poll,
              // BLOC
              color: _selectedIndex == 0 ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}