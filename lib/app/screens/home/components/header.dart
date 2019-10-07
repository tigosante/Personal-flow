import 'package:flutter/material.dart';
import 'package:personal_flow/app/screens/home/components/data_search.dart';

class Header extends StatefulWidget {
  Header({Key key}) : super(key: key);

  @override
  _HeaderState createState() => new _HeaderState();
}

class _HeaderState extends State<Header>{
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
  
}