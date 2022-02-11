import 'package:flutter/material.dart';

ThemeData defaultTheme() {
  return ThemeData(
    //primary color
    primarySwatch: Colors.yellow,

    //appBar Theme
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
    ),

    //textButton style
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.grey.shade600,
      ),
    ),
  );
}