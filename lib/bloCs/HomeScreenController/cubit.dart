
import 'package:chatbot/bloCs/HomeScreenController/state.dart';
import 'package:chatbot/bloCs/MainController/cubit.dart';
import 'package:chatbot/constant.dart';
import 'package:dialogflow_flutter/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';



class HomeScreenController extends Cubit<HomeScreenState>{

  HomeScreenController(this.context) : super(InitialState());

  static HomeScreenController get(context) => BlocProvider.of(context);

  var context;

  List<Widget> chatBoard = [];

  TextEditingController messageSender = TextEditingController();
  ScrollController chatBoardScroller = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);


  void whenUserSend(Size size,double fontSize){

    if(messageSender.value.text.isNotEmpty){

      Widget userTap = Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10,top: 10),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              width: (size.width)*.15,
              height: (size.width)*.15,
              child: ClipOval(child: Image.asset("assets/images/user.png")),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Expanded(
              // //width: (size.width)-((size.width)*.15),
              // width: 100,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30,right: 10),
                child: Text(
                  messageSender.value.text,
                  style: fixedTextStyle(font: fontSize),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
              ),
            )
          ],
        ),
      );

      chatBoard.add(userTap);

      chatBoardScroller.jumpTo(chatBoardScroller.position.maxScrollExtent+100);

      String userMessage = messageSender.value.text;

      messageSender.clear();

      emit(UserTabState());

      botResponse(size, fontSize, userMessage);

    }

  }


  Future<void> botResponse(Size size,double fontSize, message) async {

    ///debugger();

    debugPrint(message);

    AuthGoogle authGoogle = await AuthGoogle(fileJson: "assets/service.json").build();
    DialogFlow dialogflow =DialogFlow(authGoogle: authGoogle,language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(message);


    Widget botResponse = Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10,top: 10),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [

          Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: (size.width)*.15,
            height: (size.width)*.15,
            child: ClipOval(child: Image.asset("assets/images/chatbot.png")),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
          ),

          Expanded(
            // //width: (size.width)-((size.width)*.15),
            // width: 100,
            child:Padding(
              padding: const EdgeInsets.only(bottom: 20,left: 10),
              child: Text(
                aiResponse.getMessage()!,
                style: fixedTextStyle(font: fontSize),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.ltr,
              ),
            ),
          ),

        ],
      ),
    );

    chatBoard.add(botResponse);

    chatBoardScroller.jumpTo(chatBoardScroller.position.maxScrollExtent+100);

    emit(BotResponseState());

  }


  void convertMode(){

    var controller = MainController.get(context);

    controller.convertMode();

    emit(ChangeModeState());

  }


}