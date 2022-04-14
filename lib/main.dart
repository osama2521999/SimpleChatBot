import 'package:bloc/bloc.dart';
import 'package:chatbot/screen/mainScreen.dart';
import 'package:chatbot/router/router.dart';
import 'package:chatbot/screen/noInternet.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'bloCs/BlocObserver .dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Stack(
          children: [
            child ?? Container(),
            StreamBuilder(
                stream: Connectivity().onConnectivityChanged,
                builder: (context, AsyncSnapshot snapshot) {
                  //debugger();
                  if (snapshot == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var result = snapshot.data;
                  switch (result) {
                    case ConnectivityResult.wifi:
                    case ConnectivityResult.mobile:
                      return Container();
                    case ConnectivityResult.none:
                    default:
                      return const NoInternet();
                  }
                }),
          ],
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Chat Bot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: MyRouter.generateRoute,
      home: const MainScreen(),
    );
  }
}

// import 'package:dialogflow_flutter/googleAuth.dart';
// import 'package:flutter/material.dart';
// import 'package:dialogflow_flutter/dialogflowFlutter.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Colors.blue,
//         primarySwatch: Colors.blue,
//       ),
//       home: ChatBotScreen(),
//     );
//   }
// }
//
// class ChatBotScreen extends StatefulWidget {
//   @override
//   _ChatBotScreenState createState() => _ChatBotScreenState();
// }
//
// class _ChatBotScreenState extends State<ChatBotScreen> {
//   final messageInsert = TextEditingController();
//   List<Map> messsages = [];
//   void response(query) async {
//     AuthGoogle authGoogle =
//     await AuthGoogle(fileJson: "assets/service.json")
//         .build();
//     DialogFlow dialogflow = DialogFlow(authGoogle: authGoogle, language: "en");
//     AIResponse aiResponse = await dialogflow.detectIntent(query);
//     setState(() {
//       messsages.insert(0, {
//         "data": 0,
//         "message": aiResponse.getListMessage()![0]["text"]["text"][0].toString()
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         toolbarHeight: 70,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(30),
//             bottomRight: Radius.circular(30),
//           ),
//         ),
//         elevation: 10,
//         title: Text("Dailog Flow Chatbot"),
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Flexible(
//                 child: ListView.builder(
//                     reverse: true,
//                     itemCount: messsages.length,
//                     itemBuilder: (context, index) => chat(
//                         messsages[index]["message"].toString(),
//                         messsages[index]["data"]))),
//             Divider(
//               height: 6.0,
//             ),
//             Container(
//               padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
//               margin: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Row(
//                 children: <Widget>[
//                   Flexible(
//                       child: TextField(
//                         controller: messageInsert,
//                         decoration: InputDecoration.collapsed(
//                             hintText: "Send your message",
//                             hintStyle: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 18.0)),
//                       )),
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 4.0),
//                     child: IconButton(
//                         icon: Icon(
//                           Icons.send,
//                           size: 30.0,
//                         ),
//                         onPressed: () {
//                           if (messageInsert.text.isEmpty) {
//                             print("empty message");
//                           } else {
//                             setState(() {
//                               messsages.insert(0,
//                                   {"data": 1, "message": messageInsert.text});
//                             });
//                             response(messageInsert.text);
//                             messageInsert.clear();
//                           }
//                         }),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 15.0,
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget chat(String message, int data) {
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: Padding(
//         padding: EdgeInsets.all(2.0),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             CircleAvatar(
//               backgroundImage: AssetImage(
//                   data == 0 ? "assets/images/chatbot.png" : "assets/images/user.png"),
//             ),
//             SizedBox(
//               width: 10.0,
//             ),
//             Flexible(
//                 child: Text(
//                   message,
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ))
//           ],
//         ),
//       )
//     );
//   }
// }