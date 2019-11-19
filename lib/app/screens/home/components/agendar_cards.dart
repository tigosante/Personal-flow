import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:personal_flow/app/shared/tasks_functions.dart';

class AgendarCards extends StatefulWidget {
  AgendarCards({Key key, this.size_screen, this.dias_agendados}) : super(key: key);

  double size_screen;
  List<bool> dias_agendados;
  @override
  _AgendarCardsState createState() => _AgendarCardsState();
}

List<bool> dias_agendados = [];
bool agendar_unica = false;
String agenda_unica = "Definir data final desta tarefa.";
Color cor_tarefa = Colors.grey;

class _AgendarCardsState extends State<AgendarCards> {
  @override
  Widget build(BuildContext context) {
    double size_screen = 0;
    setState(() {
      size_screen = widget.size_screen;
      // dias_agendados = widget.dias_agendados;
    });

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: size_screen * 0.0005),
        borderRadius: BorderRadius.all(Radius.circular(size_screen * 0.04)),
      ),
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: size_screen * 0.015,
                bottom: size_screen * 0.015,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List<Widget>.generate(7, (dia) {
                        List<String> dias = [
                          "Dom",
                          "Seg",
                          "Ter",
                          "Qua",
                          "Qui",
                          "Sex",
                          "Sáb",
                        ];
                        setState(() {
                          if (!(dias_agendados == 7)) {
                            agendar_unica = false;
                            for (int i = 0; i < dias.length; i++) {
                              dias_agendados.add(false);
                            }
                          }
                        });
                        return InkWell(
                          child: Container(
                            padding: EdgeInsets.all(size_screen * 0.008),
                            child: Text(
                              dias[dia],
                              style: TextStyle(
                                  color: dias_agendados[dia]
                                      ? Colors.blue
                                      : Colors.grey),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              dias_agendados[dia] = !dias_agendados[dia];

                              if (dias_agendados[dia]) {
                                agendar_unica = true;
                              }

                              int contador = 0;

                              for (int i = 0; i < dias_agendados.length; i++) {
                                if (!dias_agendados[i]) {
                                  contador++;
                                }
                              }

                              if (contador == dias_agendados.length) {
                                agendar_unica = false;
                                agenda_unica =
                                    "Definir data final desta tarefa.";
                                cor_tarefa = Colors.grey;
                              }
                            });
                          },
                        );
                      })),
                ],
              ),
            ),
            InkWell(
              child: Container(
                  padding: EdgeInsets.all(size_screen * 0.008),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: size_screen * 0.03),
                        child: Text(
                          agenda_unica,
                          style: TextStyle(color: cor_tarefa),
                        ),
                      ),
                    ],
                  )),
              onTap: () async {
                bool verificar = false;
                for (int i = 0; i < dias_agendados.length; i++) {
                  if (dias_agendados[i]) {
                    verificar = true;
                  }
                }
                if (verificar) {
                  final DateTime picked = await showDatePicker(
                    context: context,
                    firstDate: new DateTime(2000),
                    lastDate: new DateTime(2030),
                    initialDate: new DateTime.now(),
                  );
                  setState(() {
                    AgendarData agendamento = AgendarData(
                      picked: picked,
                    );
                    agendar_unica = picked == null;
                    agenda_unica = agendamento.data_agendamento();

                    cor_tarefa = agendar_unica ? Colors.grey : Colors.blue;
                  });
                } else {
                  Flushbar flushbar;
                  bool _wasButtonClicked;

                  flushbar = Flushbar<bool>(
                    icon: Icon(
                      Icons.error_outline,
                      color: Colors.amber,
                    ),
                    animationDuration: Duration(milliseconds: 450),
                    message: "Escolha algum dia para agendar.",
                    borderRadius: size_screen * 0.05,
                    margin: EdgeInsets.only(
                      bottom: size_screen * 0.15,
                      left: size_screen * 0.1,
                      right: size_screen * 0.1,
                    ),
                    duration: Duration(seconds: 2),
                  )..show(context).then((result) {
                      setState(() {
                        _wasButtonClicked = result;
                      });
                    });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}