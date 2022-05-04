import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/locator.dart';
import 'package:sepapka/utils/theme_data.dart';
import 'package:sepapka/view_layer/wrapper.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:flutter/services.dart';

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
      ],
      child: MaterialApp(
        title: 'SEPapka',
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.system,
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