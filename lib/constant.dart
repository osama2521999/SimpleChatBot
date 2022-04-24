
import 'package:flutter/material.dart';

const MaterialColor color=Colors.lightGreen;


const Color appThemColor=color;

String modeType = "light";

Icon modeIcon = const Icon(Icons.light_mode_outlined);





double constFieldWidth(BuildContext context,double scale){

  return (MediaQuery.of(context).size.width)*scale;

}


List<double> buttonsHeightWidth(BuildContext context,double scaleHeight,double scaleWidth){

  double width = (MediaQuery.of(context).size.width)*scaleWidth;
  double height = (MediaQuery.of(context).size.height)*scaleHeight;

  return [width,height];

}


InputDecoration fixedInputDecoration(String text,double border,Widget? suffix){
  return InputDecoration(

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(border),

    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(border),
      borderSide:  BorderSide(
        color: color.shade100,
        width: 2.0,
      ),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(border),
      ///borderSide:  BorderSide(
      ///color: appFieldColor,
      ///),
    ),

    hintText: text,
    // labelText: text,
    //labelStyle: TextStyle(color: appFieldColor),
    suffixIcon: suffix,
    suffixText: null,
  );

}


ButtonStyle fixedButtonStyle(double circular,{Color? buttonColor ,double? elevation }){
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all( buttonColor??appThemColor ),
      elevation: MaterialStateProperty.all(elevation),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circular),
              side: BorderSide(
                //color: Colors.orangeAccent.shade700,
                color: color.shade700,
              )
          )
      )
  );
}



TextStyle fixedTextStyle({double? font, String? family,FontStyle? style,FontWeight? weight,Color? color}){
  return TextStyle(
      fontWeight: weight,
      fontStyle: style,
      color: color /*?? appBarColor*/,
      fontFamily: family,
      fontSize: font
  );
}

