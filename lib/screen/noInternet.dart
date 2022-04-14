// ignore_for_file: file_names
import 'package:flutter/material.dart';


class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/images/NoInternet.gif"),
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              ),

              const Text("No Internet",style:  TextStyle(fontFamily: 'Lemonada',fontSize: 20/*,color: appThemColor*/)),

            ],
          )
      ),
    );
  }
}
