import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/locator.dart';
import 'package:sepapka/utils/theme_data.dart';
import 'package:sepapka/view_layer/wrapper.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:flutter/services.dart';
import 'package:sepapka/viewmodel_layer/manager_academy.dart';
import 'package:sepapka/viewmodel_layer/manager_calc.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // wymagane do inicjalizacji Firebase
  await Firebase.initializeApp(); // wymagane do inicjalizacji Firebase
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Manager>(
          create: (context) => Manager(),
        ),
        ChangeNotifierProvider<CalcManager>(
        create: (context) => CalcManager(),
          lazy: true,
        ),
        ChangeNotifierProvider<AcademyManager>(
          create: (context) => AcademyManager(),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        title: 'SEPapka',
        theme: FlexThemeData.light(
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
        ),
        darkTheme: FlexThemeData.dark(
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
        ),
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,

themeMode: ThemeMode.system,

        // theme: lightTheme(),
        // darkTheme: darkTheme(),
        // themeMode: ThemeMode.dark,
        // // themeMode: ThemeMode.system,
        home: const Wrapper(),
        // routes: {
        //   '/wrapper': (context) => const Wrapper(),
        //   '/sign-in': (context) => SignInScreen(),
        //   '/reset-password': (context) => ResetPasswordScreen(),
        //   '/menu-main-screen': (context) => MenuScreen(),
        //   '/menu-choose-level': (context) => MenuChooseLevel(),
        //   '/settings-screen': (context) => SettingsScreen(),
        //   '/settings-change-user-data': (context) => ChangeUserData(),
        //   '/question-single': (context) => QuestionSingleScreen(),
        //
        // },

      ),
    );
  }
}