import 'package:flutter/material.dart';
import 'package:personal_flow/app/shared/tasks_functions.dart';

class DataHr extends StatefulWidget {
  DataHr({Key key, @required this.index, @required this.size_screem, @required this.data_list, context}) : super(key: key);

  int index;
  double size_screem;
  Map<String, dynamic> data_list;

  _DataHrState createState() => _DataHrState();
}

class _DataHrState extends State<DataHr> {
  
  @override
  Widget build(context) {
    int index = widget.index;
    double size_screem = widget.size_screem;
    Map<String, dynamic> data_list = widget.data_list;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey,),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(size_screem * 0.02),
                bottomLeft: Radius.circular(size_screem * 0.02),
                bottomRight: Radius.circular(size_screem * 0.02),
              )),
          child: dtHr(context, index, size_screem, data_list),
        ),
        data_list["$index"] == null
            ? IconButton(
                color: Colors.blue[600],
                icon: Icon(
                  Icons.calendar_today,
                ),
                onPressed: () {
                  setState(() {
                    // press = false;
                  });
                },
              )
            : IconButton(
                color: Colors.red[600],
                icon: Icon(
                  Icons.close,
                ),
                onPressed: () {
                  setState(() {
                    data_list["$index"] = null;
                  });
                },
              ),
      ],
    );
  }

  Widget dtHr(context, index, size_screem, data_list) {
    dynamic retorno;

    if (data_list["$index"] == null) {
      retorno = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            child: Container(
              margin: EdgeInsets.only(
                top: size_screem * 0.025,
                left: size_screem * 0.02,
                right: size_screem * 0.02,
                bottom: size_screem * 0.025,
              ),
              child: Text(
                "Data",
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: size_screem * 0.025,
                    fontFamily: 'Orkney-bold'),
              ),
            ),
            onTap: () async {
              final DateTime picked = await showDatePicker(
                context: context,
                firstDate: new DateTime(2000),
                lastDate: new DateTime(2030),
                initialDate: new DateTime.now(),
              );
              setState(() {
                DataHora dataHora = DataHora(picked: picked);
                dynamic retorno = dataHora.calendario();
                data_list["$index"] = retorno;
              });
            },
          ),
        ],
      );
    } else {
      retorno = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            child: Container(
              margin: EdgeInsets.only(
                top: size_screem * 0.025,
                left: size_screem * 0.02,
                right: size_screem * 0.02,
                bottom: size_screem * 0.025,
              ),
              child: Text(
                data_list["$index"]["data_form"],
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: size_screem * 0.025,
                    fontFamily: 'Orkney-bold'),
              ),
            ),
            onTap: () async {
              final DateTime picked = await showDatePicker(
                context: context,
                firstDate: new DateTime(2000),
                lastDate: new DateTime(2030),
                initialDate: new DateTime.now(),
              );
              setState(() {
                DataHora dataHora = DataHora(picked: picked);
                dynamic retorno = dataHora.calendario();
                data_list["$index"] = retorno;
              });
            },
          ),
          Text(
            " -",
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: size_screem * 0.025,
                fontFamily: 'Orkney-bold'),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(
                top: size_screem * 0.025,
                left: size_screem * 0.02,
                right: size_screem * 0.02,
                bottom: size_screem * 0.025,
              ),
              child: Text(
                data_list["$index"]["hora"] == null
                    ? "Hora"
                    : data_list["$index"]["hora"],
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: size_screem * 0.025,
                    fontFamily: 'Orkney-bold'),
              ),
            ),
            onTap: () {
              setState(() {
                hora(index, data_list);
              });
            },
          )
        ],
      );
    }
    return retorno;
  }

  hora(index, data_list) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != TimeOfDay.now()) {
      String hora;
      dynamic hora_form;

      hora = picked.toString();
      hora_form = hora
          .split("TimeOfDay")[1]
          .split("(")
          .toList()[1]
          .split(")")[0]
          .toString();
      print(hora_form);
      data_list["$index"]["hora"] = hora_form;
      print(data_list["$index"]);
    }
  }
}