import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/locator.dart';
import 'package:sepapka/utils/theme_data.dart';
import 'package:sepapka/view_layer/authenticate/reset_password_screen.dart';
import 'package:sepapka/view_layer/authenticate/sing_in_screen.dart';
import 'package:sepapka/view_layer/menu/menu_choose_level.dart';
import 'package:sepapka/view_layer/menu/menu_main_screen.dart';
import 'package:sepapka/view_layer/question_single/question_single_screen.dart';
import 'package:sepapka/view_layer/user_settings/change_user_data_screen.dart';
import 'package:sepapka/view_layer/user_settings/settings_main_screen.dart';
import 'package:sepapka/view_layer/wrapper.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

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
        // ChangeNotifierProvider<NavManager>(
        //   create: (context) => NavManager(),
        // ),
      ],
      child: MaterialApp(
        title: 'SEPapka',
        theme: defaultTheme(),
        home: const Wrapper(),
        routes: {
          '/wrapper': (context) => const Wrapper(),
          '/sign-in': (context) => SignInScreen(),
          '/reset-password': (context) => ResetPasswordScreen(),
          '/menu-main-screen': (context) => MenuScreen(),
          '/menu-choose-level': (context) => MenuChooseLevel(),
          '/settings-screen': (context) => SettingsScreen(),
          '/settings-change-user-data': (context) => ChangeUserData(),
          '/question-single': (context) => QuestionSingleScreen(),

        },

      ),
    );
  }
}