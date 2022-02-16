import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/nav.dart';


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
        centerTitle: true,
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
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  manager.errorMsg != null ? manager.errorMsg.toString() : '',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Text('lub'),
            const SizedBox(height: 10.0),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
                onPressed: () {
                  manager.signInWithGoogle();
                },
                icon: Image.asset('assets/general/images/g-logo.png',
                  height: 26,
                  width: 26,),
              label: const Text('Zaloguj się przez Google'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Nie pamiętasz hasła?'),
                TextButton(
                  onPressed: () {
                    context.read<Manager>().navigate(Screen.resetPassword);
                  },
                  child: const Text(
                    'Zresetuj hasło',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),

          // //if there's message in manager, show dialog
          // if (manager.infoMsg.isNotEmpty) MessageDialog(msg: manager.infoMsg),
          ],
        ),
      ),
    );
  }
}
