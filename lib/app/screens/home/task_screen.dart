import 'package:flutter/material.dart';
import 'package:personal_flow/app/screens/home/components/card_struct.dart';
import 'package:personal_flow/app/screens/home/components/data_search.dart';
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
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.15,
                bottom: MediaQuery.of(context).size.width * 0.02,
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07,
              ),
              child: ListTile(
                title: Text(
                  "Oi, Tiago!",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Tarefas não concluídas.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                  ),
                ),

                trailing: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.blue[600],
                  ),
                  //  BLOC
                  onPressed: () {
                    showSearch(context: context, delegate: DataSearch());
                  },
                ),
              ),
            ),

            Expanded(
              child: Center(child: CardStruct()),
            ),
          ],
        ),
      ),

      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.blue[600],

        label: Text(
          "adicionar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        icon: Icon(
          Icons.add,
          color: Colors.white,
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
