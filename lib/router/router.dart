import 'package:flutter/material.dart';
import '../screen/homeScreen.dart';
import 'RoutePaths.dart';


class MyRouter {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case RoutePaths.homeScreen:
        return MaterialPageRoute(builder: (_) =>  const HomeScreen());


      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('${settings.name} still under develop'),
              ),
            )
        );
    }
  }

}
