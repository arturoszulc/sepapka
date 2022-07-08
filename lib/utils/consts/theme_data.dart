import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

final ThemeData myLightTheme = FlexThemeData.light(
colors: const FlexSchemeColor(
primary: Color(0xffffe375),
primaryContainer: Color(0xffd0e4ff),
secondary: Color(0xff383838),
secondaryContainer: Color(0xffffdbcf),
tertiary: Color(0xff7591ff),
tertiaryContainer: Color(0xff95f0ff),
appBarColor: Color(0xffffdbcf),
error: Color(0xffb00020),
),
usedColors: 2,
surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
blendLevel: 20,
appBarOpacity: 0.00,
subThemesData: const FlexSubThemesData(
elevatedButtonRadius: 10.0,
outlinedButtonRadius: 10.0,
blendOnLevel: 20,
blendOnColors: false,
textButtonSchemeColor: SchemeColor.inverseSurface,
outlinedButtonSchemeColor: SchemeColor.inverseSurface,
fabUseShape: false,
fabSchemeColor: SchemeColor.primary,
dialogRadius: 10.0,
),
useMaterial3ErrorColors: true,
visualDensity: FlexColorScheme.comfortablePlatformDensity,
useMaterial3: false,
// To use the playground font, add GoogleFonts package and uncomment
// fontFamily: GoogleFonts.notoSans().fontFamily,
);

final ThemeData myDarkTHeme = FlexThemeData.dark(
colors: const FlexSchemeColor(
primary: Color(0xffffe375),
primaryContainer: Color(0xffd0e4ff),
secondary: Color(0xff383838),
secondaryContainer: Color(0xffffdbcf),
tertiary: Color(0xff7591ff),
tertiaryContainer: Color(0xff95f0ff),
appBarColor: Color(0xffffdbcf),
error: Color(0xffb00020),
).defaultError.toDark(0, false),
usedColors: 2,
surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
blendLevel: 15,
appBarOpacity: 0.0,
darkIsTrueBlack: true,
subThemesData: const FlexSubThemesData(
elevatedButtonRadius: 10.0,
outlinedButtonRadius: 10.0,
textButtonSchemeColor: SchemeColor.inverseSurface,
outlinedButtonSchemeColor: SchemeColor.inverseSurface,
fabUseShape: false,
fabSchemeColor: SchemeColor.primary,
dialogBackgroundSchemeColor: SchemeColor.secondary,
dialogRadius: 10.0,
),
useMaterial3ErrorColors: true,
visualDensity: FlexColorScheme.comfortablePlatformDensity,
useMaterial3: false,
// To use the playground font, add GoogleFonts package and uncomment
// fontFamily: GoogleFonts.notoSans().fontFamily,
);

