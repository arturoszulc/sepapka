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
      appBar: AppBar(title: Text('Sign In Screen'),),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              var result = manager.signIn(email: 'test', password: '111');
            },
            child: Text('Sign in'),
          ),

        ],
      ),
    );
  }
}
