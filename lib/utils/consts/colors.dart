
import 'package:flutter/material.dart';

//Light theme main colors
// const Color myPrimary = Color(0xffffe375);
// const Color myPrimaryLight = Color(0xffffffa6);
// const Color myPrimaryDark = Color(0xffc9b145);
const Color purchaseButtonColor = Color(0xff7591ff);
// const Color mySecondary = Color(0xff383838);


//Button colors
// const Color normalButtonColor = myPrimary;
Color fadedButtonColor = Colors.yellow.shade100;
const Color wrongButtonColor = Colors.redAccent;
Color rightButtonColor = Colors.green.shade500;


const List<double> matrixIdentity = [
  //R  G   B    A  Const
  1, 0, 0, 0, 0, //
  0, 1, 0, 0, 0, //
  0, 0, 1, 0, 0, //
  0, 0, 0, 1, 0, //
];
const List<double>matrixInverse = [
  //R  G   B    A  Const
  -1, 0, 0, 0, 255, //
  0, -1, 0, 0, 248, //
  0, 0, -1, 0, 224, //
  0, 0, 0, 1, 0, //
];


const ColorScheme flexSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xffffe375),
  onPrimary: Color(0xff000000),
  primaryContainer: Color(0xfffff3c7),
  onPrimaryContainer: Color(0xff282822),
  secondary: Color(0xff383838),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffafafaf),
  onSecondaryContainer: Color(0xff1e1e1e),
  tertiary: Color(0xffffff9b),
  onTertiary: Color(0xff000000),
  tertiaryContainer: Color(0xffffffff),
  onTertiaryContainer: Color(0xff282828),
  error: Color(0xffba1b1b),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad4),
  onErrorContainer: Color(0xff410001),
  outline: Color(0xff62625c),
  background: Color(0xfffdfaf2),
  onBackground: Color(0xff131312),
  surface: Color(0xfffffbee),
  onSurface: Color(0xff1e1d1c),
  surfaceVariant: Color(0xfffffae6),
  onSurfaceVariant: Color(0xff2d2c28),
  inverseSurface: Color(0xff2d291c),
  onInverseSurface: Color(0xffe6e5e4),
  inversePrimary: Color(0xffffffff),
  shadow: Color(0xff000000),
);

const ColorScheme flexSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffffe375),
  onPrimary: Color(0xff000000),
  primaryContainer: Color(0xff665a2e),
  onPrimaryContainer: Color(0xffffffff),
  secondary: Color(0xff383838),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xff161616),
  onSecondaryContainer: Color(0xffffffff),
  tertiary: Color(0xffffff9b),
  onTertiary: Color(0xff000000),
  tertiaryContainer: Color(0xffb3b325),
  onTertiaryContainer: Color(0xff000000),
  error: Color(0xffffb4a9),
  onError: Color(0xff680003),
  errorContainer: Color(0xff930006),
  onErrorContainer: Color(0xffffb4a9),
  outline: Color(0xffb3b3b3),
  background: Color(0xff100f0b),
  onBackground: Color(0xffffffff),
  surface: Color(0xff090907),
  onSurface: Color(0xffffffff),
  surfaceVariant: Color(0xff0f0e0b),
  onSurfaceVariant: Color(0xffffffff),
  inverseSurface: Color(0xffffffff),
  onInverseSurface: Color(0xff000000),
  inversePrimary: Color(0xff6b6538),
  shadow: Color(0xff000000),
);
