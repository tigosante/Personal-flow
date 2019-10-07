import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:personal_flow/app/screens/home/components/card_content.dart';
import 'package:personal_flow/app/screens/home/components/category_progress.dart';

class CardStruct extends StatefulWidget {
  CardStruct({Key key}) : super(key: key);

  @override
  _CardStructState createState() => new _CardStructState();
}

class _CardStructState extends State<CardStruct>{
  @override
  Widget build(context){
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.width * 0.15,
            ),
            itemCount: 5,
            itemBuilder: buildCardStruct,
          ),
        ),
      ],
    );
  }

  Widget buildCardStruct(BuildContext context, index) {
    return Center(
      child: Card(
        color: index%2 != 0 ? Colors.blue[100] : Colors.orange[100],
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
          
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
        ),

        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            // BLOC
            // border: Border.all(color: Colors.grey[400],),
            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.04))
          ),

            child: Slidable(
              actionPane: SlidableDrawerActionPane(),

              child: Container(
                child: Column(
                  children: <Widget>[
                    ExpandablePanel(
                      tapHeaderToExpand: true,
                      header: Container(
                        padding: EdgeInsets.only(
                          top:     MediaQuery.of(context).size.width * 0.005,
                          bottom:     MediaQuery.of(context).size.width * 0.005,
                          left:    MediaQuery.of(context).size.width * 0.03,
                        ),

                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "Reconstruindo toda a estrutura dividindo cada componente em arquivo. Também criando um BLOC para fazer as funções.",

                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.035
                                  // fontWeight: FontWeight.bold,
                                  // fontFamily: 'Qontra'
                                ),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03),
                                child: Text(
                                  "Subtítulo da tarefa",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.03,
                                    fontFamily: 'orkney-bold',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      expanded: Column(
                        children: <Widget>[
                          ListTile(
                            title: Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                              child: Text(
                                "Progresso:",

                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: MediaQuery.of(context).size.width * 0.033,
                                  fontFamily: 'orkney-bold',
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),

                            subtitle: CategoryProgress(),
                          ),

                          Container(
                            padding: EdgeInsets.only(
                              left:   MediaQuery.of(context).size.width * 0.005,
                              right:  MediaQuery.of(context).size.width * 0.005,
                            ),

                            child: Column(
                              children: <Widget>[
                                Card(
                                  elevation: 0,
                                  // BLOC
                                  color: index%2 != 0 ? Colors.blue[100] : Colors.orange[100],
                                  // color: Colors.blue[900],
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
                                  ),

                                  child: CardContent(),
                                ),

                                Padding(
                                  padding:  EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width * 0.01,
                                    top: MediaQuery.of(context).size.width * 0.01,
                                  ),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.05),
                                        ),

                                        child: Text(
                                          "Priorizar",
                                          
                                          style: TextStyle(
                                            fontFamily: 'orkney-bold',
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.black
                                          ),
                                        ),

                                        onPressed: (){},
                                      ),

                                      RaisedButton(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.05),
                                        ),

                                        child: Text(
                                          "Concluir",

                                          style: TextStyle(
                                            fontFamily: 'orkney-bold',
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white
                                          ),
                                        ),
                                        color: index%2 != 0 ? Colors.blue[400] : Colors.orange[400],
                                        onPressed: (){},

                                        // BLOC
                                        // onPressed: (){
                                        //   setState(() {
                                        //     List<bool> antigo =[];

                                        //     for(int i=0;i<subtarefas._toDoList[index]["details"].length;i++){
                                        //       antigo.add(subtarefas._toDoList[index]["details"]["$i"]["bool"]);
                                        //       subtarefas._toDoList[index]["details"]["$i"]["bool"] = true;
                                        //     }
                                            
                                        //     _calclulateProgress(index);

                                        //     final snack = SnackBar(
                                        //       content: Text("Tarefa concluídas"),
                                        //       duration: Duration(seconds: 2),

                                        //       action: SnackBarAction(
                                        //         label: "Desfazer",

                                        //         onPressed: (){
                                        //           setState(() {
                                        //             for(int i=0;i<subtarefas._toDoList[index]["details"].length;i++){
                                        //               subtarefas._toDoList[index]["details"]["$i"]["bool"] = antigo[i];
                                        //             }

                                        //             _calclulateProgress(index);
                                        //             _saveData();
                                        //         });
                                        //       },
                                        //       ),
                                        //     );

                                        //     Scaffold.of(context).removeCurrentSnackBar();
                                        //     Scaffold.of(context).showSnackBar(snack);
                                        //   });
                                        // },
                                      )
                                    ],
                                  ),
                                ),

                                Divider(
                                  color: Colors.transparent,
                                  height: MediaQuery.of(context).size.width * 0.02,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            actions: <Widget>[
              IconSlideAction(
                caption: "Arquivar",
                color: Colors.teal,
                icon: Icons.bookmark,
                onTap: (){},
              ),

            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: "Excluir",
                color: Colors.red,
                icon: Icons.delete,
                onTap: (){},
              ),

            ],

            // secondaryActions: <Widget>[
            //   IconSlideAction(
            //     caption: "Apagar",
            //     color: Colors.red,
            //     icon: Icons.delete,
            //     onTap: (){
            //       setState(() {
            //         _lastRemoved     =  Map.from(subtarefas._toDoList[index]);
            //         _lastRemovedPos  =  index;

            //         subtarefas._toDoList.removeAt(index);
            //         _cardCrontroller.removeAt(index);

            //         _refresh();

            //         final snack = SnackBar(
            //           content: Text("Tarefa removida"),
            //           duration: Duration(seconds: 2),

            //           action: SnackBarAction(
            //             label: "Desfazer",

            //             onPressed: (){
            //               setState(() {
            //                 subtarefas._toDoList.insert(_lastRemovedPos, _lastRemoved);
            //                 _cardCrontroller.insert(_lastRemovedPos, false);

            //                 _refresh();
            //                 _saveData();
            //             });
            //           },
            //           ),
            //         );

            //         Scaffold.of(context).removeCurrentSnackBar();
            //         Scaffold.of(context).showSnackBar(snack);
            //       });
            //     },
            //   ),
            // ],

          ),
        ),
      ),
    );
  }
  
}