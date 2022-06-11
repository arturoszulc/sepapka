import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/locator.dart';
import 'package:sepapka/utils/consts/theme_data.dart';
import 'package:sepapka/view_layer/authenticate/reset_password_screen.dart';
import 'package:sepapka/view_layer/authenticate/sing_in_screen.dart';
import 'package:sepapka/view_layer/wrapper.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:flutter/services.dart';
import 'package:sepapka/viewmodel_layer/manager_academy.dart';
import 'package:sepapka/viewmodel_layer/manager_calc.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:sepapka/utils/consts/nav.dart';


void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // wymagane do inicjalizacji Firebase
  await Firebase.initializeApp(); // wymagane do inicjalizacji Firebase
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setupGetIt();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
      child: Builder(
        builder: (context) {
          final _router = Provider.of<Manager>(context).router;
          return MaterialApp.router(
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
            title: 'SEPapka',
            theme: myLightTheme,
            darkTheme: myDarkTHeme,
            themeMode: ThemeMode.system,


          );
        },

      ),
    );
  }

}