import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String>{
  // Subtarefas subtarefas = Subtarefas();

  List<String> sugestoes = [];

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
      onPressed: (){},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // for (var item in subtarefas._toDoList) {
    //   sugestoes.add(item["title"]);

    //   int cont = 0;
    //   for (var itemDetails in item["details"]) {
    //     sugestoes.add(itemDetails["$cont"]["title"]);
    //   }
    // }
    // List<String> cities = [];

    // final segestions = query.isEmpty ? sugestoes : cities;
    // return ListView.builder(
    //   itemBuilder: (context, index)=> ListTile(leading: Icon(Icons.location_city), title: Text(sugestoes[index]),),
    //   itemCount: segestions.length,
    // );
  }
	
}