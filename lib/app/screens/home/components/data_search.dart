import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String>{
  // Subtarefas subtarefas = Subtarefas();

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