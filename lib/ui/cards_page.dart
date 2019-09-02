import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:projeto_integrador_i/style/theme.dart' as Theme;
import 'package:projeto_integrador_i/utils/bubble_indication_painter_cards.dart';

class CardsPage extends StatefulWidget {
  CardsPage({Key key}) : super(key: key);

  @override
  _CardsPageState createState() => new _CardsPageState();
}

class _CardsPageState extends State<CardsPage>
  with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _obscureTextLogin         = true;
  bool _obscureTextSignup        = true;
  bool _obscureTextSignupConfirm = true;

  PageController _pageController;

  Color left  = Colors.white;
  Color right = Colors.white;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,

      body: NotificationListener<OverscrollIndicatorNotification>(
        child: SingleChildScrollView(
          child: Container(
            width:   MediaQuery.of(context).size.width,
            height:  MediaQuery.of(context).size.height >= 700.0 ? MediaQuery.of(context).size.height : 700.0,

            decoration: new BoxDecoration(
              color: Colors.white
            ),

            child: Column(
              mainAxisSize: MainAxisSize.max,
              
              children: <Widget>[                
                Expanded(
                  flex: 2,

                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,

                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child:       _buildTimeLine(context),
                      ),

                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child:       _buildFluxo(context),
                      ),
                    ],

                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child:   _buildMenuBar(context),
                ),

              ],
            ),

          ),
        ),

      ),
    );

  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();

  }

  @override
  void initState() {
    super.initState();

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);

    _pageController = PageController();

  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width:  MediaQuery.of(context).size.width * 0.85,

      decoration: BoxDecoration(
        color: Colors.teal[100],

        border: Border.all(
          color: Colors.teal[50],
          width: 2,
        ),

        borderRadius: BorderRadius.all(
          Radius.circular(25.0)
        ),
      ),

      child: CustomPaint(
        painter: TabIndicationPainterCards(pageController: _pageController),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            Expanded(
              child: FlatButton(
                onPressed:      _onTimelineButtonPress,

                child: Text(
                  "Timeline",

                  style: TextStyle(
                    color:      Colors.black87,
                    fontSize:   16.0,
                    fontFamily: "ComfortaaBold"
                  ),
                ),

              ),
            ),

            Expanded(
              child: FlatButton(
                onPressed:      _onFluxoButtonPress,

                child: Text(
                  "Fluxo",

                  style: TextStyle(
                    color:      Colors.black87,
                    fontSize:   16.0,
                    fontFamily: "ComfortaaBold"
                  ),
                ),

              ),
            ),

          ],
        ),

      ),
    );

  }

  Widget _buildTimeLine(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      color:   Colors.white,
      width:   MediaQuery.of(context).size.width * 0.7,

      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left:   20.0,
              top:    20.0,
              bottom: 40.0,
            ),

            child: Text(
              "Todas as terfas",

              style: TextStyle(
                color: Colors.teal[800],
                fontSize: 25,
                fontFamily: "ComfortaaBold",
              ),
            ),
          ),

          Container(
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    const ListTile(
                      leading:  Icon(
                        Icons.work,
                        color: Theme.Colors.corDark,
                      ),

                      title:    Text(
                        'Terminar CRUD - SDM',
                        style: TextStyle(fontFamily: "ComfortaaBold"),
                        textAlign: TextAlign.left,
                        textScaleFactor: 0.9,
                      ),

                      subtitle: Text(
                        'Organizar todos os filtros no Controller e organizar os Scripts no Model.',
                        style: TextStyle(fontFamily: "ComfortaaRegular"),
                        textAlign: TextAlign.left,
                        textScaleFactor: 0.9,
                      ),
                    ),

                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child:     const Text("Editar", style: TextStyle(fontFamily: "ComfortaaBold"),textScaleFactor: 0.9,),
                            textColor: Colors.black,

                            onPressed: (){},
                          ),

                          FlatButton(
                            child: const Text("Concluído", style: TextStyle(fontFamily: "ComfortaaBold"),textScaleFactor: 0.9,),
                            textColor: Colors.blue[400],

                            onPressed: (){},
                          ),

                          FlatButton(
                            child: const Text("Priorizar", style: TextStyle(fontFamily: "ComfortaaBold"),textScaleFactor: 0.9,),
                            textColor: Colors.red[700],
                            
                            onPressed: (){},
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

              ),
            ),

          ),
          
          Container(            
            child: Container(
              // padding: EdgeInsets.only(top: 5.0),

              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    const ListTile(
                      leading:  Icon(
                        Icons.work,
                        color: Theme.Colors.corDark,
                      ),

                      title: Text(
                        "Terminar Relatório - SQG",
                        style: TextStyle(fontFamily: "ComfortaaBold"),
                        textAlign: TextAlign.left,
                        textScaleFactor: 0.9,
                      ),

                      subtitle: Text(
                        "Organiar estrutura do relatório.",
                        style: TextStyle(fontFamily: "ComfortaaRegular"),
                        textAlign: TextAlign.left,
                        textScaleFactor: 0.9,
                        maxLines: 2,
                      ),
                    ),

                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child:     const Text("Editar", style: TextStyle(fontFamily: "ComfortaaBold"), textScaleFactor: 0.9,),
                            textColor: Colors.black,

                            onPressed: (){},
                          ),

                          FlatButton(
                            child: const Text("Concluído", style: TextStyle(fontFamily: "ComfortaaBold"), textScaleFactor: 0.9,),
                            textColor: Colors.blue[400],

                            onPressed: (){},
                          ),

                          FlatButton(
                            child: const Text("Priorizar", style: TextStyle(fontFamily: "ComfortaaBold"), textScaleFactor: 0.9,),
                            textColor: Colors.red[700],
                            
                            onPressed: (){},
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

              ),
            ),

          ),

          Container(            
            child: Container(
              // padding: EdgeInsets.only(top: 5.0),

              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    const ListTile(
                      leading:  Icon(
                        Icons.person,
                        color: Colors.teal,
                      ),

                      title: Text(
                        "Organização",
                        style: TextStyle(fontFamily: "ComfortaaBold"),
                        textAlign: TextAlign.left,
                        textScaleFactor: 0.9,
                      ),

                      subtitle: Text(
                        "Organizar as tarefas de casa.",
                        style: TextStyle(fontFamily: "ComfortaaRegular"),
                        textAlign: TextAlign.left,
                        textScaleFactor: 0.9,
                        maxLines: 2,
                      ),
                    ),

                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child:     const Text("Editar", style: TextStyle(fontFamily: "ComfortaaBold"), textScaleFactor: 0.9,),
                            textColor: Colors.black,

                            onPressed: (){},
                          ),

                          FlatButton(
                            child: const Text("Concluído", style: TextStyle(fontFamily: "ComfortaaBold"), textScaleFactor: 0.9,),
                            textColor: Colors.blue[400],

                            onPressed: (){},
                          ),

                          FlatButton(
                            child: const Text("Priorizar", style: TextStyle(fontFamily: "ComfortaaBold"),textScaleFactor: 0.9,),
                            textColor: Colors.red[700],
                            
                            onPressed: (){},
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

              ),
            ),

          ),

          Container(            
            child: Container(
              // padding: EdgeInsets.only(top: 5.0),

              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    const ListTile(
                      leading:  Icon(
                        Icons.school,
                        color: Colors.amber,
                      ),

                      title: Text(
                        "Estudo",
                        style: TextStyle(fontFamily: "ComfortaaBold"),
                        textAlign: TextAlign.left,
                        textScaleFactor: 0.9,
                      ),

                      subtitle: Text(
                        "Estudar a disciplina bônus, vulgo cálculo 1.",
                        style: TextStyle(fontFamily: "ComfortaaRegular"),
                        textAlign: TextAlign.left,
                        textScaleFactor: 0.9,
                        maxLines: 2,
                      ),
                    ),

                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child:     const Text("Editar", style: TextStyle(fontFamily: "ComfortaaBold"), textScaleFactor: 0.9,),
                            textColor: Colors.black,

                            onPressed: (){},
                          ),

                          FlatButton(
                            child: const Text("Concluído", style: TextStyle(fontFamily: "ComfortaaBold"), textScaleFactor: 0.9,),
                            textColor: Colors.blue[400],

                            onPressed: (){},
                          ),

                          FlatButton(
                            child: const Text("Priorizar", style: TextStyle(fontFamily: "ComfortaaBold"), textScaleFactor: 0.9,),
                            textColor: Colors.red[700],
                            
                            onPressed: (){},
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

              ),
            ),

          ),

          Container(            
            child: Container(
              // padding: EdgeInsets.only(top: 5.0),

              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    const ListTile(
                      leading:  Icon(
                        Icons.sync_problem,
                        color: Colors.blue,
                      ),

                      title: Text(
                        "Projeto Integradr I",
                        style: TextStyle(fontFamily: "ComfortaaBold"),
                        textAlign: TextAlign.left,
                        textScaleFactor: 0.9,
                      ),

                      subtitle: Text(
                        "Não surtar, não pirar",
                        style: TextStyle(fontFamily: "ComfortaaRegular"),
                        textAlign: TextAlign.left,
                        textScaleFactor: 0.9,
                        maxLines: 2,
                      ),
                    ),

                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child:     const Text("Editar", style: TextStyle(fontFamily: "ComfortaaBold"), textScaleFactor: 0.9,),
                            textColor: Colors.black,

                            onPressed: (){},
                          ),

                          FlatButton(
                            child: const Text("Concluído", style: TextStyle(fontFamily: "ComfortaaBold"), textScaleFactor: 0.9,),
                            textColor: Colors.blue[400],

                            onPressed: (){},
                          ),

                          FlatButton(
                            child: const Text("Priorizar",style: TextStyle(fontFamily: "ComfortaaBold"),textScaleFactor: 0.9,),
                            textColor: Colors.red[700],
                            
                            onPressed: (){},
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

              ),
            ),

          ),

        ],
        
        
      ),
    );

  }

  Widget _buildFluxo(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 23.0
      ),

      child: Column(),

    );

  }

  void _onTimelineButtonPress() {
    _pageController.animateToPage(
      0,

      duration: Duration(
        milliseconds: 500
      ),

      curve: Curves.decelerate
    );

  }

  void _onFluxoButtonPress() {
    _pageController.animateToPage(
      1,

      duration: Duration(
        milliseconds: 500
      ),

      curve: Curves.decelerate
    );

  }

}
