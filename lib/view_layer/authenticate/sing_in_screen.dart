import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _authFormKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String? error;

  @override
  Widget build(BuildContext context) {
    debugPrint('*** SignInScreen built ***');
    final manager = Provider.of<Manager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: [
            Form(
              key: _authFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 20.0),

                  //pole EMAIL
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Adres e-mail',
                    ),
                    onChanged: (val) {
                      email = val;
                    },
                  ),

                  //pole PASSWORD
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Hasło',
                    ),
                    onChanged: (val) {
                      password = val;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                manager.signIn(email: email, password: password);
                // manager.addQuestionsToDb();
              },
              child: const Text('Zaloguj'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                manager.errorMsg != null ? manager.errorMsg.toString() : '',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Stwórz konto', style: TextStyle(color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}
