// import 'package:flutter/material.dart';
// import 'package:personal_flow/app/screens/home/components/data_search.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class Header extends StatefulWidget {
//   Header({Key key}) : super(key: key);

//   @override
//   _HeaderState createState() => new _HeaderState();
// }

// class _HeaderState extends State<Header>{
//   @override
//   Widget build(BuildContext context) {
//     return SmartRefresher(
//       enablePullUp: false,
//       enablePullDown: true,
//       onRefresh: null,
//       onLoading: null,
//       controller: null,

//       header: WaterDropMaterialHeader(
//         backgroundColor: Colors.black,
//       ),
      
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(context).size.width * 0.15,
//               bottom: MediaQuery.of(context).size.width * 0.02,
//             ),

//             child: Row(
//               mainAxisAlignment:  MainAxisAlignment.start,

//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: MediaQuery.of(context).size.width * 0.07,
//                   ),
//                 ),

//                 Expanded(
//                   child: ListTile(
//                     title: Text(
//                       "Oi, Tiago!",

//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: MediaQuery.of(context).size.width * 0.05,
//                         fontWeight: FontWeight.bold
//                       ),
//                     ),
//                     subtitle: Text(
//                       "Fazer função que atualiza a quantidade de tarefas",

//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: MediaQuery.of(context).size.width * 0.03,
//                       ),

//                     ),

//                   ),
//                 ),

//                 IconButton(
//                   icon: Icon(Icons.search, color: Colors.black,),
//                   onPressed: (){
//                     showSearch(context: context, delegate: DataSearch());
//                   },
//                 ),

//                 Padding(
//                   padding: EdgeInsets.only(
//                     right: MediaQuery.of(context).size.width * 0.07,
//                   ),
//                 ),

//               ],
//             ),
//           ),

//           Expanded(
//             child: Center(
//                 child: buildCardsDetails(context)
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
// }