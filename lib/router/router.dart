import 'package:flutter/material.dart';
import '../screen/mainScreen.dart';
import 'RoutePaths.dart';


class MyRouter {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case RoutePaths.mainScreen:
        return MaterialPageRoute(builder: (_) =>  const MainScreen());


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
