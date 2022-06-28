import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/services/route_service.dart';
import 'package:sepapka/utils/consts/theme_data.dart';
import 'package:flutter/services.dart';
import 'package:sepapka/viewmodel_layer/app_state_controller.dart';


void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // wymagane do inicjalizacji Firebase
  await Firebase.initializeApp(); // wymagane do inicjalizacji Firebase
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // setupGetIt();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, WidgetRef ref, child) {
          final _router = ref.read(routerProvider);
          //manager initialization to check if user is signed in
          ref.read(appStateNotifierProvider.notifier).init();

          Future.delayed(Duration.zero, (){
          });
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