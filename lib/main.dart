import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/screens/menu_screen.dart';
import 'package:sepapka/screens/question_list_screen.dart';
import 'package:sepapka/screens/question_single_screen.dart';
import 'package:sepapka/screens/wrapper.dart';

import 'models/logged_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoggedUser>(
      create: (context) => LoggedUser(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.yellow,
        ),
        home: const Wrapper(),

        routes: {
          '/menu':(context) => const Menu(),
          '/question-list': (context) => const QuestionListScreen(),
          '/question-single': (context) => QuestionSingleScreen(),

        },
      ),
    );
  }
}