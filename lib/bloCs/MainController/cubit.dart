import 'package:chatbot/bloCs/MainController/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant.dart';


class MainController extends Cubit<MainState>{

  MainController(this.context) : super(InitialState());

  static MainController get(context) => BlocProvider.of(context);

  var context;

  void convertMode(){

    if(modeType=="light"){
      modeType="dark";
      modeIcon=const Icon(Icons.dark_mode_outlined);
    }else{
      modeType="light";
      modeIcon=const Icon(Icons.light_mode_outlined);
    }

    emit(ChangeModeState());

  }


  ThemeData mainThem(){
    if(modeType=="light"){
      return ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light
      );
    }else{
      return ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark
      );
    }
  }


}