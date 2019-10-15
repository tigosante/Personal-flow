import 'package:flutter/material.dart';
import 'package:personal_flow/app/shared/tasks_functions.dart';

class NewTask extends StatefulWidget {
  NewTask({Key key, @required this.toDoList}) : super(key: key);

  List toDoList;

  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TextEditingController controller_titulo = TextEditingController();
  List<TextEditingController> controller_sub = [TextEditingController()];
  @override
  Widget build(BuildContext context) {
    List toDoList = widget.toDoList;
    TasksProp tasksProp = TasksProp(context_screen: context);
    double size_screem = tasksProp.outScreenSize;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Nova Tarefa"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          Container(
            // BLOC
            padding: EdgeInsets.only(
              left: size_screem * 0.05,
              right: size_screem * 0.05,
            ),
            child: Padding(
              // BLOC
              padding: EdgeInsets.only(
                left: size_screem * 0.02,
              ),
              child: TextField(
                // BLOC
                // controller: _textoToDOTitle,
                controller: controller_titulo,

                decoration: InputDecoration(
                  hintText: "Título",
                  border: InputBorder.none,
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Column(
            // BLOC
            children: List<Widget>.generate(controller_sub.length,
                (int index) => buildDetailsBody(context, index, size_screem)),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue[600],
        onPressed: () {
          setState(() {
            if (addToDo()) {
              Navigator.pop(context, toDoList);
            } else {
              Navigator.pop(context, null);
            }
          });
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text(
          "Adicionar",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget buildDetailsBody(context, index, size_screem) {
    return Container(
      padding: EdgeInsets.only(
        left: size_screem * 0.05,
        right: size_screem * 0.05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
              // BLOC
              padding: EdgeInsets.only(
                left: size_screem * 0.02,
                right: size_screem * 0.02,
              ),

              child: TextField(
                controller: controller_sub[index],
                decoration: InputDecoration(
                  hintText: "Tarefa",
                  border: InputBorder.none,
                  labelStyle: TextStyle(
                    color: Colors.blue[600],
                  ),
                ),
              ),
            ),
          ),
          controller_sub[index] == controller_sub[controller_sub.length - 1]
              ? IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    setState(() {
                      controller_sub.add(TextEditingController());
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    setState(() {
                      controller_sub.removeAt(index);
                    });
                  },
                ),
        ],
      ),
    );
  }

  addToDo() {
    if (controller_titulo.text.trim() != "") {
      Map<String, dynamic> newToDo = Map();
      Map<String, dynamic> details = Map();

      newToDo["title"] = controller_titulo.text.trim();
      newToDo["ok"] = false;

      for (int i = 0; i < controller_sub.length; i++) {
        if (controller_sub[i].text.trim() != "") {
          Map<String, dynamic> content = Map();
          content["title"] = controller_sub[i].text.trim();
          content["bool"] = false;
          details["$i"] = content;
        }
      }

      newToDo["details"] = details;

      widget.toDoList.insert(0, newToDo);

      return true;
    } else {
      return false;
    }
  }
}
