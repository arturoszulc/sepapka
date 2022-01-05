import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('SignInScreen built');
    final manager = Provider.of<Manager>(context);
    return Center(
      child: ElevatedButton(
        onPressed: () {
          var result = manager.signIn(email: 'test', password: '111');
        },
        child: Text('Sign in'),
      ),
    );
  }
}
