import 'package:flutter/material.dart';

final ThemeData _androidTheme = ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    primarySwatch: Colors.blueGrey,
    primaryColor: Color.fromRGBO(158, 201, 252, 1), //blue
    accentColor: Color.fromRGBO(0, 204, 161, 1), //turquoise
    backgroundColor: Color.fromRGBO(240, 242, 243, 1), //light grey
    bottomAppBarColor: Color.fromRGBO(0, 204, 161, 1),
    dividerColor: Colors.grey,
    buttonColor: Color.fromRGBO(0, 204, 161, 1),
    splashColor: Colors.transparent,
    errorColor: Color.fromRGBO(208, 2, 27, 1),
    iconTheme: IconThemeData(color: Color.fromRGBO(38, 77, 121, 1)),
    textTheme: TextTheme(caption: TextStyle(color: Colors.grey)),
    primaryTextTheme: TextTheme(
        headline5: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headline6: TextStyle(color: Colors.white),
        subtitle1: TextStyle(
            fontWeight: FontWeight.bold, color: Color.fromRGBO(38, 77, 121, 1)),
        bodyText1: TextStyle(color: Color.fromRGBO(0, 204, 161, 1)),
        bodyText2: TextStyle(
            fontWeight: FontWeight.bold, color: Color.fromRGBO(38, 77, 121, 1)),
        button: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        caption: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
    accentTextTheme: TextTheme(
        headline5: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        headline6: TextStyle(color: Colors.black),
        subtitle1: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        bodyText2:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600])));

final ThemeData _iOSTheme = ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    primarySwatch: Colors.blueGrey,
    primaryColor: Color.fromRGBO(158, 201, 252, 1), //blue
    accentColor: Color.fromRGBO(0, 204, 161, 1), //turquoise
    backgroundColor: Color.fromRGBO(240, 242, 243, 1), //light grey
    bottomAppBarColor: Color.fromRGBO(0, 204, 161, 1),
    dividerColor: Colors.grey,
    buttonColor: Color.fromRGBO(0, 204, 161, 1),
    splashColor: Colors.transparent,
    errorColor: Color.fromRGBO(208, 2, 27, 1),
    iconTheme: IconThemeData(color: Color.fromRGBO(38, 77, 121, 1)),
    textTheme: TextTheme(caption: TextStyle(color: Colors.grey)),
    primaryTextTheme: TextTheme(
        headline5: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headline6: TextStyle(color: Colors.white),
        subtitle1: TextStyle(
            fontWeight: FontWeight.bold, color: Color.fromRGBO(38, 77, 121, 1)),
        bodyText1: TextStyle(color: Color.fromRGBO(0, 204, 161, 1)),
        bodyText2: TextStyle(
            fontWeight: FontWeight.bold, color: Color.fromRGBO(38, 77, 121, 1)),
        button: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        caption: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
    accentTextTheme: TextTheme(
        headline5: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        headline6: TextStyle(color: Colors.black),
        subtitle1: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        bodyText2:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600])));

/// Return ThemeData based on current OS
ThemeData getAdaptiveTheme(BuildContext context) {
  return Theme.of(context).platform == TargetPlatform.iOS
      ? _iOSTheme
      : _androidTheme;
}
