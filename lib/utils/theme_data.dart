import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme() {

  const Color myPrimary = Color(0xffffe375);
  const Color mySecondary = Color(0xff383838);

  return ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: myPrimary,
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
      foregroundColor: mySecondary,
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
        primary: myPrimary, //button color
        onPrimary: mySecondary, //text button color
      ),
    ),

    //iconButton style
    // iconTheme: IconThemeData(
    //   color: const Color(0xff383838),
    //   // style: IconButton.styleFrom(
    //   //   primary: const Color(0xffffe375), //button color
    //   //   onPrimary: const Color(0xff383838), //text button color
    //   // ),
    // ),,

    //text form input style
    textSelectionTheme: const TextSelectionThemeData(cursorColor: mySecondary),
      inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: mySecondary,
        )
      ),
      // focusColor: mySecondary,

      labelStyle: TextStyle(
        color: mySecondary,
      ),
    ),

  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
  );
}
