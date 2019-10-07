import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:personal_flow/main.dart';
import 'App_bloc.dart';

class AppModule extends ModuleWidget{
  @override
  List<Bloc<BlocBase>> get blocs => [
    Bloc((i)=> AppBloc()),
  ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => MyApp();

  static Inject get to => Inject<AppModule>.of();

}