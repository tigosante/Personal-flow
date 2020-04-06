import 'package:flutter/material.dart';

class IngoUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: Text("Tiago Silva"),
            subtitle: Text("tsilvasantos38@gmail.com"),
            leading: CircleAvatar(
              backgroundColor: Color.fromRGBO(128, 128, 128, 0.2),
              child: Icon(
                Icons.person_outline,
                color: Colors.grey,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
