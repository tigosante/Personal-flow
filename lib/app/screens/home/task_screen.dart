import 'package:flutter/material.dart';
import 'package:personal_flow/app/screens/home/components/card_struct.dart';
import 'package:personal_flow/app/screens/home/components/header.dart';
import 'package:personal_flow/app/screens/new_task/new_task.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({Key key}) : super(key: key);

  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        // BLOC
        enablePullUp: false,
        enablePullDown: true,
        onRefresh: null,
        onLoading: null,
        controller: RefreshController(initialRefresh: false),
        header: WaterDropMaterialHeader(
          backgroundColor: Colors.blue[600],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Header(),
            Expanded(
              child: Center(child: CardStruct()),
            ),
          ],
        ),
      ),

      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.white,

        label: Text(
          "adicionar",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'orkey-bold'),
        ),

        icon: Icon(
          Icons.add,
          color: Colors.black,
        ),
        // BLOC
        onPressed: () {
          // subtarefas._textoToDODetaiLisvet.clear();
          // subtarefas._textoToDODetaiLisvet.add(TextEditingController());
          // _subtarefasSize = 1;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewTask(),
              ));
        },
      ),
    );
  }
}
