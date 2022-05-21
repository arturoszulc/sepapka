
import 'package:flutter/material.dart';

//Light theme main colors
// const Color myPrimary = Color(0xffffe375);
// const Color myPrimaryLight = Color(0xffffffa6);
// const Color myPrimaryDark = Color(0xffc9b145);
// const Color myComplementary = Color(0xff7591ff);
// const Color mySecondary = Color(0xff383838);


//Button colors
// const Color normalButtonColor = myPrimary;
Color fadedButtonColor = Colors.yellow.shade100;
const Color wrongButtonColor = Colors.redAccent;
Color rightButtonColor = Colors.green.shade500;


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
  outline: Color(0xff625e5e),
  background: Color(0xfffffcf4),
  onBackground: Color(0xff141313),
  surface: Color(0xfffffdf9),
  onSurface: Color(0xff0a0909),
  surfaceVariant: Color(0xfffffcf4),
  onSurfaceVariant: Color(0xff141313),
  inverseSurface: Color(0xff1a1914),
  onInverseSurface: Color(0xfff6f5f5),
  inversePrimary: Color(0xffffffff),
  shadow: Color(0xff000000),
);

const ColorScheme flexSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffffe375),
  onPrimary: Color(0xff1e1e13),
  primaryContainer: Color(0xff665a2e),
  onPrimaryContainer: Color(0xffe8e5db),
  secondary: Color(0xff383838),
  onSecondary: Color(0xffededed),
  secondaryContainer: Color(0xff161616),
  onSecondaryContainer: Color(0xffd5d5d5),
  tertiary: Color(0xffffff9b),
  onTertiary: Color(0xff1e1e18),
  tertiaryContainer: Color(0xffb3b325),
  onTertiaryContainer: Color(0xff2e2e0d),
  error: Color(0xffffb4a9),
  onError: Color(0xff680003),
  errorContainer: Color(0xff930006),
  onErrorContainer: Color(0xffffb4a9),
  outline: Color(0xff999995),
  background: Color(0xff1f1d16),
  onBackground: Color(0xffe4e4e3),
  surface: Color(0xff171613),
  onSurface: Color(0xfff1f1f1),
  surfaceVariant: Color(0xff1e1c16),
  onSurfaceVariant: Color(0xffe4e4e3),
  inverseSurface: Color(0xfffffefb),
  onInverseSurface: Color(0xff0f0e0e),
  inversePrimary: Color(0xff736d3f),
  shadow: Color(0xff000000),
);
