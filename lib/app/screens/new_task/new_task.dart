import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:personal_flow/app/shared/tasks_functions.dart';

class NewTask extends StatefulWidget {
  NewTask({Key key, @required this.toDoList}) : super(key: key);

  List toDoList;

  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  bool press = true;
  TextEditingController controller_titulo = TextEditingController();
  List<TextEditingController> controller_sub = [TextEditingController()];

  List<String> data_list = [];

  @override
  Widget build(BuildContext context) {
    List toDoList = widget.toDoList;
    TasksProp tasksProp = TasksProp(context_screen: context);
    double size_screem = tasksProp.outScreenSize;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Nova Tarefa"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: size_screem * 0.07,
                right: size_screem * 0.07,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.all(
                    Radius.circular(size_screem * 0.02)
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size_screem * 0.02
                  ),
                  child: TextField(
                    controller: controller_titulo,
                    decoration: InputDecoration(
                      labelText: "Título",
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.transparent,
              height: size_screem * 0.05,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        left: size_screem * 0.07,
                        right: size_screem * 0.07,
                      ),
                      itemCount: controller_sub.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildDetailsBody(context, index, size_screem),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
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
    // DataHora dataHora = DataHora(
    //   context: context,
    //   data_list: data_list,
    // );
    // dynamic calendario = dataHora.calendario();

    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size_screem * 0.02),
                topRight: Radius.circular(size_screem * 0.02),
                bottomLeft: Radius.circular(size_screem * 0.02),
              )),
          child: Padding(
            padding: EdgeInsets.only(left: size_screem * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller_sub[index],
                    decoration: InputDecoration(
                      hintText: "Tarefa",
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                    minLines: 1,
                  ),
                ),
                controller_sub[index] == controller_sub[controller_sub.length - 1]
                    ? IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.blue[600],
                        ),
                        onPressed: () {
                          setState(() {
                            controller_sub.add(TextEditingController());
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red[600],
                        ),
                        onPressed: () {
                          setState(() {
                            controller_sub.removeAt(index);
                          });
                        },
                      ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            dataHora(context, size_screem)
          ],
        ),
        Divider(
          color: Colors.transparent,
          height: size_screem * 0.02,
        ),
      ],
    );
  }

  Widget dataHora(context, size_screem){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(size_screem * 0.02),
              bottomLeft: Radius.circular(size_screem * 0.02))),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(size_screem * 0.02),
                    bottomLeft: Radius.circular(size_screem * 0.02),
                    bottomRight: Radius.circular(size_screem * 0.02),
                  )),
              width: size_screem * 0.23,
              // width: size_screem * 0.1,
              height: size_screem * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Text(
                  //   "Data",
                  //   style: TextStyle(
                  //     color: Colors.blue[600],
                  //     fontFamily: 'Orkney-bold'),
                  // ),
                  Text(
                    "Sáb, 19 Out",
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontFamily: 'Orkney-bold'),
                  ),
                  Text(
                    " - ",
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontFamily: 'Orkney-bold'),
                  ),
                  // Text(
                  //   "Hora",
                  //   style: TextStyle(
                  //     color: Colors.blue[600],
                  //     fontFamily: 'Orkney-bold'),
                  // ),
                  Text(
                    "19:30",
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontFamily: 'Orkney-bold'),
                  ),
                ],
              ),
            ),
            press
                ? IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.blue[600],
                    ),
                    onPressed: () {
                      setState(() {
                        press = false;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.red[600],
                    ),
                    onPressed: () {
                      setState(() {
                        press = true;
                      });
                    },
                  ),
          ],
        ),
        onTap: () {
          print("foi");
        },
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

  hora() async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != TimeOfDay.now()) {
      print(picked);
    }
  }
}
