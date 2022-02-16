import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color(0xffffe375),
      // secondary: const Color(0xff383838),
      // onSurface:  const Color(0xff383838),
      // background:  const Color(0xff383838),
      // onSurface: const Color(0xffffe375),
      // surface: const Color(0xffffe375),
      // onBackground: const Color(0xffffe375),
    ),


    //primary color
    // primarySwatch: Colors.yellow,

    //appBar Theme
    appBarTheme: const AppBarTheme(
      brightness: Brightness.light,
      elevation: 0,
      color: Colors.transparent,
    ),

    //textButton style
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.grey.shade600,
      ),
    ),

    //elevatedButton style
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xffffe375), //button color
        onPrimary: const Color(0xff383838), //text button color
      ),
    ),

    //iconButton style
    iconTheme: IconThemeData(
      color: const Color(0xff383838),
      // style: IconButton.styleFrom(
      //   primary: const Color(0xffffe375), //button color
      //   onPrimary: const Color(0xff383838), //text button color
      // ),
    ),

  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
  );
}
