import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class CategoryProgress extends StatefulWidget {
  CategoryProgress({Key key}) : super(key: key);

  _CategoryProgressState createState() => _CategoryProgressState();
}

class _CategoryProgressState extends State<CategoryProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.06,
      child: Card(
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
            
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
          ),

          child: FAProgressBar(
            displayText: "  ",
            maxValue: 10,
            currentValue: 2,
            progressColor: Colors.orange[300],
            // maxValue: subtarefas._toDoList[index]["details"].length,
            // currentValue: subtarefas.completos,
            // progressColor: index%2 != 0 ? Colors.blue[300] : Colors.orange[300],
            backgroundColor: Colors.grey[50]
          ),
      ),
    );
  }
}