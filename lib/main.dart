import 'package:bloc/bloc.dart';
import 'package:chatbot/bloCs/mainController/cubit.dart';
import 'package:chatbot/screen/homeScreen.dart';
import 'package:chatbot/router/router.dart';
import 'package:chatbot/screen/noInternet.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloCs/BlocObserver .dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const Test());
    },
    blocObserver: MyBlocObserver(),
  );
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainController>(
          create: (context) => MainController(context),
        ),
      ],
      child: const MyApp(),
    );
  }
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
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   brightness: Brightness.dark
      // ),
      ///theme: mainThem(),
      theme: context.select((MainController controller) => controller.mainThem()),
      onGenerateRoute: MyRouter.generateRoute,
      home: const HomeScreen(),
    );
  }
}