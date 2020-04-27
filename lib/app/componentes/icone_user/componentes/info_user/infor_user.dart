import 'package:flutter/material.dart';

import '../../icone_user.dart';

class InfoUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(children: <Widget>[
        Expanded(
            child: ListTile(
                title: Text("Tiago Silva"),
                subtitle: Text("tsilvasantos38@gmail.com"),
                leading: IconUser(),
                trailing: IconButton(
                    icon: Icon(Icons.exit_to_app, color: Colors.red),
                    onPressed: () {})))
      ]);
}
