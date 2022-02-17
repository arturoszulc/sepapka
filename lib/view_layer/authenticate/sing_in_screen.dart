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
        title: const Text('Logowanie'),
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
                    obscureText: true,
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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                child: Text(
                  manager.errorMsg.toString(),
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            // const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      manager.signIn(email: email, password: password);
                      // manager.addQuestionsToDb();
                    },
                    child: const Text('Zaloguj się'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      manager.register(email: email, password: password);
                      // manager.addQuestionsToDb();
                    },
                    child: const Text('Utwórz konto'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text('lub'),
            const SizedBox(height: 10.0),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
                onPressed: () {
                  manager.signInWithGoogle();
                },
                icon: Image.asset('assets/images/general/g-logo.png',
                  height: 22,
                  width: 22,),
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
