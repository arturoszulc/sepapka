import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/locator.dart';
import 'package:sepapka/view_layer/menu/menu_screen.dart';
import 'package:sepapka/view_layer/menu/settings_screen.dart';
import 'package:sepapka/view_layer/question_single_screen.dart';
import 'package:sepapka/view_layer/wrapper.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import 'model_layer/services/auth_service.dart';


void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // wymagane do inicjalizacji Firebase
  await Firebase.initializeApp(); // wymagane do inicjalizacji Firebase
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

        // StreamProvider<User?>.value(
        //   initialData: null,
        //   catchError: (context, err) {
        //     debugPrint('StreamProvider<User?> catched Error:');
        //     debugPrint(err.toString());
        //     return null;
        //   },
        //   value: serviceLocator.get<AuthService>().user,
        // )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: const Wrapper(),
        routes: {
          '/wrapper': (context) => const Wrapper(),
          '/menu-screen': (context) => Menu(),
          '/settings-screen': (context) => Settings(),
          '/question-single': (context) => QuestionSingleScreen(),

        },

      ),
    );
  }
}