// ignore_for_file: file_names
import 'package:chatbot/bloCs/HomeScreenController/cubit.dart';
import 'package:chatbot/bloCs/HomeScreenController/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;


    return BlocProvider(
      create: (context) => HomeScreenController(context),
      child: BlocConsumer<HomeScreenController,MainScreenState>(
        listener: (context, state) {},
        builder: (context, state) {

          var controller = HomeScreenController.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Center(child: Text("Home Screen",style: fixedTextStyle(font: 24,family: 'cairo')),),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient:  LinearGradient(
                      colors: [
                        appThemColor,
                        Colors.green,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                ),
              ),
              actions: [
                IconButton(
                  icon: modeIcon,
                  onPressed: (){
                    controller.convertMode();
                  },
                  iconSize: fontSize*1.5,
                ),
              ],
            ),

            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children:  [

                  // SizedBox(
                  //   //color: Colors.orange,
                  //   width: size.width,
                  //   // height: (size.height)*.715,
                  //   height: (size.height)*.79,
                  //   //height: (size.height)*.66,
                  //   child: SingleChildScrollView(
                  //     controller: controller.chatBoardScroller,
                  //     child: Column(
                  //       children: controller.chatBoard,
                  //     ),
                  //   ),
                  //
                  // ),

                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      //color: Colors.orange,
                      child: SingleChildScrollView(
                        controller: controller.chatBoardScroller,
                        child: Column(
                          children: controller.chatBoard,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    // color: Colors.black38,
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: controller.messageSender,
                        decoration: fixedInputDecoration("Write Massage here...",10.0,
                          IconButton(
                              icon: const Icon(Icons.send,color: appThemColor,textDirection: TextDirection.rtl),
                              onPressed: (){
                                controller.whenUserSend(size, fontSize);
                              }
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          );

        },
      ),
    );
  }
}
