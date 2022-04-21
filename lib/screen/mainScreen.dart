// ignore_for_file: file_names
import 'package:chatbot/bloCs/MainScreenController/cubit.dart';
import 'package:chatbot/bloCs/MainScreenController/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width)/25;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(child: Text("Main Screen",style: fixedTextStyle(font: 24,family: 'cairo')),),
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
      ),

      body: BlocProvider(
        create: (context) => MainScreenController(context),
        child: BlocConsumer<MainScreenController,MainScreenState>(
          listener: (context, state) {},
          builder: (context, state) {

            var controller = MainScreenController.get(context);
            return GestureDetector(
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
                    child: Container(
                      // color: Colors.orange,
                      child: SingleChildScrollView(
                        controller: controller.chatBoardScroller,
                        child: Column(
                          children: controller.chatBoard,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
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
            );

          },
        ),
      ),

    );
  }
}
