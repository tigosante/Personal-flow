import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notifications_helper.dart';

class NotificationWidget extends StatefulWidget {
  NotificationWidget({Key key}) : super(key: key);

  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  FlutterLocalNotificationsPlugin notifications = new FlutterLocalNotificationsPlugin();

  @override
  initState() {
    super.initState();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification:null);
        // onDidReceiveLocalNotification:(id, title, body, playload)=> onDidReceiveLocalNotification(playload));

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
        
    notifications.initialize(initializationSettings,
        onSelectNotification: null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: ListView(
         children: <Widget>[
           Container(
             child: Text("Básico"),
           ),
           RaisedButton(
             child: Text("Mastrar notificações"),
             onPressed: ()=> showOngoingNotification(notifications, title: "Comprar ovos", body: "2 tarefas concluídas de 5.", id: 0),
           )
         ],
       ),
    );
  }
}