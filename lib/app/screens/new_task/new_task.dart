import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  NewTask({Key key}) : super(key: key);

  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Nova Tarefa"),
        backgroundColor: Colors.transparent,
      ),

      body:Column(
        children: <Widget>[
          Container(
            // BLOC
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Padding(
              // BLOC
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
              ),
              child: TextField(
                // BLOC
                // controller: _textoToDOTitle,
                controller: TextEditingController(),

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
            children: List<Widget>.generate(1, (int index) => buildDetailsBody(context, index)),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue[600],
        onPressed: (){
          // BLOC
          setState(() {
            // if(_addToDo()){
              Navigator.pop(context);
            // }
          });
        },

        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),

        label: Text(
          "Adicionar",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),

      backgroundColor: Colors.white,
    );
  }

  Widget buildDetailsBody(context, index){
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),

      child: Row(
        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
        mainAxisSize:       MainAxisSize.max,

        children: <Widget>[
          Expanded(
            child: Container(
              // BLOC
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02,
              ),

              child: TextField(
                // controller: subtarefas._textoToDODetaiLisvet[index],
                controller: TextEditingController(),

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

          // BLOC
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: (){},
          ),
        ],

      ),
    );
  }
}