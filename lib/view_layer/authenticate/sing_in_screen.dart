import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  String error = '';
  @override
  Widget build(BuildContext context) {
    debugPrint('*** SignInScreen built ***');
    final manager = Provider.of<Manager>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In Screen'),),
      body: Center(
        child:
          ElevatedButton(
            onPressed: () {
              manager.signIn(email: 'test@test.pl', password: '123456');
              // manager.addQuestionsToDb();
            },
            child: const Text('Zaloguj'),
          ),


      ),
    );
  }
}
