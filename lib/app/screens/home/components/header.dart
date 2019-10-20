import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  Header({Key key}) : super(key: key);

  @override
  _HeaderState createState() => new _HeaderState();
}

class _HeaderState extends State<Header> {
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
          "Olá, Tiago!",
          style: TextStyle(
              // color: Colors.grey[800],
              fontSize: MediaQuery.of(context).size.width * 0.045,
              fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.search,
            // color: Colors.blue[600],
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

class DataSearch extends SearchDelegate<String>{
  List<String> sugestoes = [];
  List<String> foi = [
    "Terminar isso aqui",
    "O mais rápido!"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){})];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    for (var item in foi) {
      sugestoes.add(item);
    }
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index)=> InkWell(child: ListTile(leading: Icon(Icons.history), title: Text(sugestoes[index]),), onTap: (){},),
    );
  }
	
}
