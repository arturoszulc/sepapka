import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/locator.dart';
import 'package:sepapka/utils/consts/theme_data.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // wymagane do inicjalizacji Firebase
  await Firebase.initializeApp(); // wymagane do inicjalizacji Firebase
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  setupGetIt();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, WidgetRef ref, child) {
          final _router = ref.read(manager).router;
          return MaterialApp.router(
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
            title: 'SEPapka',
            theme: myLightTheme,
            darkTheme: myDarkTHeme,
            themeMode: ThemeMode.system,


          );
        },

      );

  }

}