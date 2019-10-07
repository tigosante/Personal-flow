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
      children: List<Widget>.generate(4, (int index) => buildBody(context, index))
    );
  }

  Widget buildBody(context, index){
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.01),
      child: Container(
        decoration: BoxDecoration(
          color: index%2 == 0 ? Colors.grey[100] : Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.04))
        ),
        // BLOC
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.01,
          bottom: MediaQuery.of(context).size.width * 0.01,
        ),
        
        child: Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          mainAxisSize:       MainAxisSize.max,

          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(
                  "Reconstruindo toda a estrutura dividindo cada componente em arquivos Também criando um BLOC para fazer as funções.",

                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.034
                  ),
                ),

                trailing: IconButton(
                  icon: Icon(Icons.panorama_fish_eye, color: Colors.black), //subtarefas._toDoList[index]["details"]["0"]["bool"] ?  Icon(Icons.check_circle, color: Colors.black54,) : Icon(Icons.panorama_fish_eye, color: Colors.black,),
                  onPressed: null
                    // setState(() {
                    //   subtarefas._toDoList[index]["details"]["0"]["bool"] = !subtarefas._toDoList[index]["details"]["0"]["bool"];
                    //   _calclulateProgress(index);
                    //   _saveData();
                    // });
                  // },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}