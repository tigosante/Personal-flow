import 'package:flutter/material.dart';

class CardContent extends StatefulWidget {
  CardContent({Key key}) : super(key: key);

  _CardContentState createState() => _CardContentState();
}

class _CardContentState extends State<CardContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:   MainAxisAlignment.spaceEvenly,
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: List<Widget>.generate(5, (int index) => buildBody(context, index))
    );
  }

  Widget buildBody(context, index){
    return Container(
      // BLOC
      padding: EdgeInsets.only(
        top: // subtarefas._toDoList[index]["details"]["$index"] == subtarefas._toDoList[index]["details"]["0"] ? 
        MediaQuery.of(context).size.width * 0.03, //: 0,
        bottom: // subtarefas._toDoList[index]["details"]["$index"] == subtarefas._toDoList[index]["details"]["${-1}"] ? MediaQuery.of(context).size.width * 0.03 :
         0,
        left: MediaQuery.of(context).size.width * 0.02,
        right: MediaQuery.of(context).size.width * 0.02,
      ),
      
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            mainAxisSize:       MainAxisSize.max,

            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    right: MediaQuery.of(context).size.width * 0.02,
                  ),

                  child: Text(
                    "Reconstruindo toda a estrutura dividindo cada componente em arquivos Também criando um BLOC para fazer as funções.",

                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              IconButton(
                icon: Icon(Icons.panorama_fish_eye), //subtarefas._toDoList[index]["details"]["0"]["bool"] ?  Icon(Icons.check_circle, color: Colors.black54,) : Icon(Icons.panorama_fish_eye, color: Colors.black,),
                onPressed: (){
                  // setState(() {
                  //   subtarefas._toDoList[index]["details"]["0"]["bool"] = !subtarefas._toDoList[index]["details"]["0"]["bool"];
                  //   _calclulateProgress(index);
                  //   _saveData();
                  // });
                },
              )
            ],
          ),

          // BLOC
          Padding(
            padding: EdgeInsets.only(
              top: // subtarefas._toDoList[index]["details"]["$index"] == subtarefas._toDoList[index]["details"]["0"] ? 
              MediaQuery.of(context).size.width * 0.035 //: 0,
            )
          ),

          // BLOC
          // subtarefas._toDoList[index]["details"]["$index"] == subtarefas._toDoList[index]["details"]["${-1}"] ? 
          //  Divider(height: 0, color: Colors.black, indent: MediaQuery.of(context).size.width * 0.02, endIndent: MediaQuery.of(context).size.width * 0.14,), //: Divider(height: 0, color: Colors.transparent,),

          // BLOC
          Padding(
            padding:
            EdgeInsets.only(
              bottom: //subtarefas._toDoList[index]["details"]["$index"] == subtarefas._toDoList[index]["details"]["${-1}"] ? 
              MediaQuery.of(context).size.width * 0.005 //: 0,
            )
          ),
        ],
      ),
    );
  }
}