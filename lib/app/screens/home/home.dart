import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:path_provider/path_provider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class Subtarefas{
  List _toDoList               =  [];
  List<TextEditingController> _textoToDODetaiLisvet = [];

  int completos = 0;
}


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home>{

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  
  int _selectedIndex = 0;

  int _lastRemovedPos;
  Map<String, dynamic> _lastRemoved;

  List<bool> _cardCrontroller  =  [];

  final _textoToDOTitle    =  TextEditingController();

  Subtarefas subtarefas = new Subtarefas();
  int _subtarefasSize = 1;

  List<int> _quantidadeItens = [];

  Color _cor = Colors.red[200];
  String _tarefas = "";

  @override
  initState(){
    super.initState();

    _readyData().then((data){
      setState(() {
        subtarefas._toDoList = jsonDecode(data);

        for (int i=0; i<subtarefas._toDoList.length; i++){
          _cardCrontroller.add(false);
        }

        int _cont = 0;
        for (var _ok in subtarefas._toDoList){
          if(!(_ok["ok"])){
            _cont++;
          }
        }

        _tarefas = _cont > 0  ? _cont == 1 ? "Você tem 1 tarefa pendente!" : "Você tem ${subtarefas._toDoList.length} tarefas pendentes!" : "Nenhuma tarefa cadastrada.";

        for (int i=1;i<subtarefas._toDoList.length;i++){
          _quantidadeItens.add(i);
        }

      });
    });
  }


  Future<Null> _refresh() async{
    setState(() {
      subtarefas._toDoList.sort((a, b){
        if       (a["ok"]   &&  !b["ok"])  return 1;
        else if  (!a["ok"]  &&  b["ok"])   return -1;
        else     return 0;
      });
      
      int _cont = 0;
      for (var _ok in subtarefas._toDoList){
        if(!(_ok["ok"])){
          _cont++;
        }
      }

      _tarefas = _cont > 0  ? _cont == 1 ? "Você tem 1 tarefa pendente!" : "Você tem ${subtarefas._toDoList.length} tarefas pendentes!" : "Nenhuma tarefa cadastrada.";

      _refreshController.refreshCompleted();
      _saveData();
    });

    return null;
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    if(mounted)
    setState(() {
      _refresh();
    });
    _refreshController.loadComplete();
  }
  

  @override
  Widget build(BuildContext context) {
    List pages = [buildCards(context), Container(color: Colors.white,)];

    return new Scaffold(
      body: pages.elementAt(_selectedIndex),

      bottomNavigationBar: TitledBottomNavigationBar(
        currentIndex: _selectedIndex,
        activeColor: Colors.blue[600],
        curve: Curves.easeInOut,

        onTap: (tapPage){
          setState(() {
            _selectedIndex = tapPage;
          });
        },

        items: [
          TitledNavigationBarItem(
            title: "Tarefas",
            icon: Icons.playlist_add_check,
          ),

          TitledNavigationBarItem(
            title: "Gráfico",
            icon: Icons.poll,
          ),
        ],
      ),

    );
  }

  Widget buildCards(BuildContext context) {
    return InnerDrawer(
      onTapClose: true,
      leftOffset: 0.05,
      leftAnimationType: InnerDrawerAnimation.linear,

      leftChild: Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Text("Painel com opções de vavegação: Arquivados, configurações, lixeira(talvez)"),
            ),
          ),
        ),
      ),

      scaffold: new Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        floatingActionButton: FloatingActionButton.extended(
          elevation: 3,
          clipBehavior: Clip.antiAlias,
          backgroundColor: Colors.blue[600],

          label: Text(
            "adicionar",

            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: (){
            subtarefas._textoToDODetaiLisvet.clear();
            subtarefas._textoToDODetaiLisvet.add(TextEditingController());
            _subtarefasSize = 1;
            Navigator.push(context, MaterialPageRoute(builder: (context) => buildDetails(context),));
          },
        ),

        body: SmartRefresher(
          enablePullUp: false,
          enablePullDown: true,
          onRefresh: _refresh,
          onLoading: _onLoading,
          controller: _refreshController,

          header: WaterDropMaterialHeader(
            backgroundColor: Colors.blue[600],
          ),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.15,
                  bottom: MediaQuery.of(context).size.width * 0.02,
                ),

                child: Row(
                  mainAxisAlignment:  MainAxisAlignment.start,

                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07,
                      ),
                    ),

                    Expanded(
                      child: ListTile(
                        title: Text(
                          "Oi, Tiago!",

                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        subtitle: Text(
                          _tarefas,

                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),

                        ),

                      ),
                    ),

                    IconButton(
                      icon: Icon(Icons.search, color: Colors.black,),
                      onPressed: (){
                        showSearch(context: context, delegate: DataSearch());
                      },
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.07,
                      ),
                    ),

                  ],
                ),
              ),

              Expanded(
                child: Center(
                    child: buildCardsDetails(context)
                ),
              ),

              // Expanded(
              //   child: Center(
              //     child: buildArquivados(context),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );

  }


  _addToDo(){
    if(_textoToDOTitle.text.trim() != ""){
        Map<String, dynamic> newToDo  =  Map();
        Map<String, dynamic> details  =  Map();
        Map<String, dynamic> content  =  Map();

        newToDo["title"]  =  _textoToDOTitle.text.trim();
        newToDo["ok"]     =  false;
        
        _textoToDOTitle.text   =  "";

        _cardCrontroller.insert(0, false);

        for(int i=0;i<subtarefas._textoToDODetaiLisvet.length;i++){
          if(subtarefas._textoToDODetaiLisvet[i].text.trim() != "") {
            content["title"]  =  subtarefas._textoToDODetaiLisvet[i].text.trim();
            content["bool"]   =  false;
            details["$i"] = content;
          }
        }

        subtarefas._textoToDODetaiLisvet.clear();

        newToDo["details"] = details;

        subtarefas._toDoList.insert(0, newToDo);

        _saveData();

        return true;
    }else{
      return false;
    }
  }

  Widget buildCardsDetails(context){
    return Column(
      children: <Widget>[
        Expanded(
          child: 
          // ReorderableListView(
          //   children: List<Widget>.generate(subtarefas._toDoList.length, (int index) =>buildItem(context, index, ValueKey(index))),
          //   onReorder: (int oldIndex, int newIndex) {
          //     // setState(() {
          //     //   print(newIndex);
          //     //     var item = subtarefas._toDoList[oldIndex];
          //     //     subtarefas._toDoList.removeAt(oldIndex);
          //     //     subtarefas._toDoList.insert(newIndex, item);
          //     // });
          //   },
          // )
          ListView.builder(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.width * 0.15,
            ),
            itemCount:    subtarefas._toDoList.length,
            itemBuilder:  buildItem,
          ),
        ),
      ],
    );
  }

  Widget buildItem(context, index){
    return Center(
      // key: _key,

      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Card(
          // elevation: 1.5,
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
            
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
          ),

          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: index%2 == 0 ? Colors.blue[100] : Colors.orange[100],),
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.04))
              
            ),
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),

              child: Container(
                child: Column(
                  children: <Widget>[
                    ExpandablePanel(
                      hasIcon: true,
                      tapHeaderToExpand: true,
                      header: Container(
                        padding: EdgeInsets.only(
                          top:     MediaQuery.of(context).size.width * 0.005,
                          bottom:  MediaQuery.of(context).size.width * 0.005,
                          left:    MediaQuery.of(context).size.width * 0.03,
                        ),

                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                subtarefas._toDoList[index]["title"],

                                style: TextStyle(
                                  color: index%2 == 0 ? Colors.blue[900] : Colors.orange[900],
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              
                              subtitle:  subtarefas._toDoList[index]["details"].length < 1 ? null : (subtarefas._toDoList[index]["details"].length == 1 ? Text( "${subtarefas._toDoList[index]["details"].length} subtarefa não concluída." ,style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, color: index%2 == 0 ? Colors.blue[600] : Colors.orange[600],)) : Text( "${subtarefas._toDoList[index]["details"].length} subtarefas não concluídas." ,style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, color: index%2 == 0 ? Colors.blue[600] : Colors.orange[600],))),
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
                                  color: index%2 == 0 ? Colors.blue[400] : Colors.orange[400],
                                  fontSize: MediaQuery.of(context).size.width * 0.032,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),

                            subtitle: buildcategoryProgress(context, index),
                          ),

                          Container(
                              padding: EdgeInsets.only(
                                left:   MediaQuery.of(context).size.width * 0.02,
                                right:  MediaQuery.of(context).size.width * 0.02,
                              ),

                              child: Column(
                                children: <Widget>[
                                  Card(
                                    elevation: 0,
                                    color: index%2 == 0 ? Colors.blue[100] : Colors.orange[100],
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
                                    ),

                                    child:Column(
                                      mainAxisAlignment:   MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:  CrossAxisAlignment.start,
                                      children: List<Widget>.generate(subtarefas._toDoList[index]["details"].length, (int index) =>buildBody(context, index))
                                    ),
                                  ),

                                  Divider(
                                    color:  Colors.transparent,
                                    height: MediaQuery.of(context).size.width * 0.08,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.05),
                                        ),

                                        child: Text(
                                          "Priorizar",
                                          
                                          style: TextStyle(
                                            color: index%2 == 0 ? Colors.blue[600] : Colors.orange[600],
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
                                            color: Colors.black,
                                          ),
                                        ),
                                        color: index%2 == 0 ? Colors.blue[50] : Colors.orange[50],

                                        onPressed: (){
                                          setState(() {
                                            if(!subtarefas._toDoList[index]["ok"]){
                                              List<bool> antigo =[];

                                              if(!subtarefas._toDoList[index]["ok"]){
                                                subtarefas._toDoList[index]["ok"] = !subtarefas._toDoList[index]["ok"];
                                              }

                                              for(int i=0;i<subtarefas._toDoList[index]["details"].length;i++){
                                                antigo.add(subtarefas._toDoList[index]["details"]["$i"]["bool"]);
                                                subtarefas._toDoList[index]["details"]["$i"]["bool"] = true;
                                                subtarefas.completos++;
                                              }

                                              final snack = SnackBar(
                                                content: Text("Tarefa concluídas"),
                                                duration: Duration(seconds: 2),

                                                action: SnackBarAction(
                                                  label: "Desfazer",

                                                  onPressed: (){
                                                    setState(() {
                                                      for(int i=0;i<subtarefas._toDoList[index]["details"].length;i++){
                                                        subtarefas._toDoList[index]["details"]["$i"]["bool"] = antigo[i];
                                                        subtarefas.completos--;
                                                      }

                                                      subtarefas._toDoList[index]["ok"] = false;

                                                      _saveData();
                                                  });
                                                },
                                                ),
                                              );

                                              Scaffold.of(context).removeCurrentSnackBar();
                                              Scaffold.of(context).showSnackBar(snack);
                                            }
                                          });
                                        },
                                      )
                                    ],
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

                    Container(
                      height: MediaQuery.of(context).size.width * 0.02,
                      color: index%2 == 0 ? Colors.blue[100] : Colors.orange[100],
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
                caption: "Apagar",
                color: Colors.red,
                icon: Icons.delete,
                onTap: (){
                  setState(() {
                    _lastRemoved     =  Map.from(subtarefas._toDoList[index]);
                    _lastRemovedPos  =  index;

                    subtarefas._toDoList.removeAt(index);
                    _cardCrontroller.removeAt(index);

                    _refresh();

                    final snack = SnackBar(
                      content: Text("Tarefa removida"),
                      duration: Duration(seconds: 2),

                      action: SnackBarAction(
                        label: "Desfazer",

                        onPressed: (){
                          setState(() {
                            subtarefas._toDoList.insert(_lastRemovedPos, _lastRemoved);
                            _cardCrontroller.insert(_lastRemovedPos, false);

                            _refresh();
                            _saveData();
                        });
                      },
                      ),
                    );

                    Scaffold.of(context).removeCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(snack);
                  });
                },
              ),
            ],

              ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, index){
    return Container(
      padding: EdgeInsets.only(
        top: subtarefas._toDoList[index]["details"]["$index"] == subtarefas._toDoList[index]["details"]["0"] ? MediaQuery.of(context).size.width * 0.03 : 0,
        bottom: subtarefas._toDoList[index]["details"]["$index"] == subtarefas._toDoList[index]["details"]["${-1}"] ? MediaQuery.of(context).size.width * 0.03 : 0,
        left: subtarefas._toDoList[index]["details"]["0"]["bool"] ? 0 : MediaQuery.of(context).size.width * 0.02,
        right: subtarefas._toDoList[index]["details"]["0"]["bool"] ? MediaQuery.of(context).size.width * 0.02 : 0,
      ),
      
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            mainAxisSize:       MainAxisSize.max,

            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(
                    subtarefas._toDoList[index]["details"]["0"]["title"],

                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  leading: subtarefas._toDoList[index]["details"]["0"]["bool"] ?
                      IconButton(
                        icon: Icon(Icons.check_circle, color: Colors.black54,),
                        onPressed: (){
                          setState(() {
                            if(subtarefas._toDoList[index]["details"].length > 1){
                              if(subtarefas._toDoList[index]["details"]["0"]["bool"]){
                                subtarefas._toDoList[index]["details"]["0"]["bool"] = !subtarefas._toDoList[index]["details"]["0"]["bool"];
                                subtarefas.completos--;
                              }else{
                                subtarefas._toDoList[index]["details"]["0"]["bool"] = !subtarefas._toDoList[index]["details"]["0"]["bool"];
                                subtarefas.completos++;
                              }
                            }else{
                              if(subtarefas._toDoList[index]["details"]["0"]["bool"]){
                                subtarefas._toDoList[index]["details"]["0"]["bool"] = !subtarefas._toDoList[index]["details"]["0"]["bool"];
                                subtarefas.completos--;
                                subtarefas._toDoList[index]["ok"] = false;
                              }else{
                                subtarefas._toDoList[index]["details"]["0"]["bool"] = !subtarefas._toDoList[index]["details"]["0"]["bool"];
                                subtarefas.completos++;
                                subtarefas._toDoList[index]["ok"] = true;
                              }
                            }

                            _saveData();
                          });
                        },
                      ) : null,

                  trailing: subtarefas._toDoList[index]["details"]["0"]["bool"] ? null :
                      IconButton(
                        icon: subtarefas._toDoList[index]["details"]["0"]["bool"] ?  Icon(Icons.check_circle, color: Colors.transparent,) : Icon(Icons.panorama_fish_eye, color: Colors.black,),
                        onPressed: (){
                          setState(() {
                            if(subtarefas._toDoList[index]["details"].length > 1){
                              if(subtarefas._toDoList[index]["details"]["0"]["bool"]){
                                subtarefas._toDoList[index]["details"]["0"]["bool"] = !subtarefas._toDoList[index]["details"]["0"]["bool"];
                                subtarefas.completos--;
                              }else{
                                subtarefas._toDoList[index]["details"]["0"]["bool"] = !subtarefas._toDoList[index]["details"]["0"]["bool"];
                                subtarefas.completos++;
                              }
                            }else{
                              if(subtarefas._toDoList[index]["details"]["0"]["bool"]){
                                subtarefas._toDoList[index]["details"]["0"]["bool"] = !subtarefas._toDoList[index]["details"]["0"]["bool"];
                                subtarefas.completos--;
                                subtarefas._toDoList[index]["ok"] = false;
                              }else{
                                subtarefas._toDoList[index]["details"]["0"]["bool"] = !subtarefas._toDoList[index]["details"]["0"]["bool"];
                                subtarefas.completos++;
                                subtarefas._toDoList[index]["ok"] = true;
                              }
                            }

                            _saveData();
                          });
                        },
                      )
                ),
              ),
            ],
          ),

          Padding(
            padding:
            EdgeInsets.only(
              top: subtarefas._toDoList[index]["details"]["$index"] == subtarefas._toDoList[index]["details"]["0"] ? MediaQuery.of(context).size.width * 0.035 : 0,
            )
          ),

          subtarefas._toDoList[index]["details"]["$index"] == subtarefas._toDoList[index]["details"]["${-1}"] ?  Divider(height: 0, color: Colors.blue[600], indent: MediaQuery.of(context).size.width * 0.02, endIndent: MediaQuery.of(context).size.width * 0.14,) : Divider(height: 0, color: Colors.transparent,),

          Padding(
            padding:
            EdgeInsets.only(
              bottom: subtarefas._toDoList[index]["details"]["$index"] == subtarefas._toDoList[index]["details"]["${-1}"] ? MediaQuery.of(context).size.width * 0.005 : 0,
            )
          ),
        ],
      ),
    );
  }

  Widget buildDetails(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Nova Tarefa"),
        backgroundColor: Colors.transparent,
      ),

      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Card(
              elevation: 0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
              ),

              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02,
                ),
                child: TextField(
                  controller: _textoToDOTitle,

                  decoration: InputDecoration(
                    hintText: "Título",
                    border: InputBorder.none,
                    
                    labelStyle: TextStyle(
                      color: Colors.blue[600],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: List<Widget>.generate(_subtarefasSize, (int index) =>buildDetailsBody(context, index)).toList(),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: (){
          setState(() {
            if(_addToDo()){
              _refresh();
              Navigator.pop(context);
            }
          });
        },

        icon: Icon(
          Icons.add,
          color: Colors.blue[600],
        ),

        label: Text(
          "Adicionar",
          style: TextStyle(
            color: Colors.blue[600]
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
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02,
              ),

              child: TextField(
                controller: subtarefas._textoToDODetaiLisvet[index],

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

          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: _addSub,
          ),
        ],

      ),
    );
  }

  Widget buildcategoryProgress(BuildContext context, index) {
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
            maxValue: subtarefas._toDoList[index]["details"].length,
            currentValue: subtarefas.completos,
            progressColor: index%2 == 0 ? Colors.blue[300] : Colors.orange[300],
            backgroundColor: Colors.grey[50]
          ),
      ),
    );
  }

  Widget buildArquivados(BuildContext context) {
    bool isExpandedCab = false;
    return ExpansionPanelList(
      expansionCallback: (item, isExpanded){
        setState(() {
          isExpandedCab = isExpanded;
        });
      },
      

      children: <ExpansionPanel>[
        ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: isExpandedCab,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Text("Terefas arquivadas");
          },

          body: buildCardsDetails(context),
        )
      ],
    );
  }


  void _addSub(){
    setState(() {
      subtarefas._textoToDODetaiLisvet.add(TextEditingController());
      _subtarefasSize++;
    });
  }

  Future<File> _saveData() async{
    String data  =  jsonEncode(subtarefas._toDoList);
    final file   =  await _getFile();

    return file.writeAsString(data);
  }

  Future<String> _readyData() async{
    try{
      final file = await _getFile();

      return file.readAsString();
    }catch(e){
      return null;
    }
  }
  
  Future<File> _getFile() async{
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

}


class DataSearch extends SearchDelegate<String>{
  Subtarefas subtarefas = Subtarefas();

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
    for (var item in subtarefas._toDoList) {
      sugestoes.add(item["title"]);

      int cont = 0;
      for (var itemDetails in item["details"]) {
        sugestoes.add(itemDetails["$cont"]["title"]);
      }
    }
    List<String> cities = [];

    final segestions = query.isEmpty ? sugestoes : cities;
    return ListView.builder(
      itemCount: segestions.length,
      itemBuilder: (context, index)=> ListTile(leading: Icon(Icons.location_city), title: Text(sugestoes[index]),),
    );
  }
	
}

