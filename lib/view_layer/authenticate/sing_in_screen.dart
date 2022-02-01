import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/view_layer/custom_widgets/custom_snackbar.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final _authFormKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    debugPrint('*** SignInScreen built ***');

    final manager = Provider.of<Manager>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    manager.signIn(email: email, password: password);
                    // manager.addQuestionsToDb();
                  },
                  child: const Text('Zaloguj się'),
                ),
                ElevatedButton(
                  onPressed: () {
                    manager.register(email: email, password: password);
                    // manager.addQuestionsToDb();
                  },
                  child: const Text('Utwórz konto'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                manager.errorMsg != null ? manager.errorMsg.toString() : '',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text('lub'),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Sign In with Google'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Nie pamiętasz hasła?'),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/reset-password');
                    },
                    child: const Text(
                      'Zresetuj hasło',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),),
              ],
            ),
            //if error, show snackBar
            if (manager.errorMsg != null) CustomSnackBar(errorMsg: manager.errorMsg.toString()),

          ],
        ),
      ),
    );
  }
}
