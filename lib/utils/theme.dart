import 'package:flutter/material.dart';

AppBarTheme appBarTheme = const AppBarTheme(backgroundColor: Colors.white);

//LightTheme
ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    textTheme: lightTextTheme,
    scaffoldBackgroundColor:const Color(0xFFF2F1F7),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
titleTextStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 19.0,color: Colors.black),
  )
  );

TextStyle lightTextStyle = const TextStyle(
  fontSize: 20,
  color: Colors.black,
);
TextTheme lightTextTheme = TextTheme(
  bodyText1: lightTextStyle,
);

//DarkTheme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,

);

TextStyle darkTextStyle = const TextStyle(
  fontSize: 20,
  color: Colors.white,
);
TextTheme darkTextTheme = TextTheme(
  bodyText1: darkTextStyle,
);
