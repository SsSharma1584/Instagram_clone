import 'package:flutter/material.dart';

class MyTheme{
  static ThemeData lightTheme(context)=>ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: Theme.of(context).textTheme
    )
  );

  static ThemeData darkTheme(context) => ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      elevation: 0.0,
       iconTheme: IconThemeData(color: Colors.white),
      textTheme: Theme.of(context).textTheme
    )
  );
}