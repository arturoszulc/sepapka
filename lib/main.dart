import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/locator.dart';
import 'package:sepapka/view_layer/question_single_screen.dart';
import 'package:sepapka/view_layer/wrapper.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';


void main() {
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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: const Wrapper(),
        routes: {
          '/wrapper': (context) => const Wrapper(),
          '/question-single': (context) => const QuestionSingleScreen(),

        },

      ),
    );
  }
}