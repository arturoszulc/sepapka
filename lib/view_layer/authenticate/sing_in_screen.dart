import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/colors.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final _authFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    debugPrint('*** SignInScreen built ***');

    final manager = Provider.of<Manager>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                  //pole EMAIL
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      initialValue: manager.email.value,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Adres e-mail',
                        errorText: manager.email.error,
                      ),
                      onChanged: (String val) {
                        manager.validateEmail(val);
                      },
                      onTap: () => manager.setError(null),
                    ),
                  ),

                  //pole PASSWORD
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      initialValue: manager.password.value,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Hasło',
                        errorText: manager.password.error,
                        errorMaxLines: 2,
                      ),
                      onChanged: (String val) {
                        manager.validatePassword(val);
                      },
                      onTap: () => manager.setError(null),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 5.0),
                child: Text(
                  manager.errorMsg.toString(),
                  style: TextStyle(color: isDarkMode ? flexSchemeDark.error : flexSchemeLight.error),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: ElevatedButton(onPressed: (!manager.isEmailAndPasswordValid)
                        ? null : () =>
                        manager.signIn(
                            email: manager.email.value!, password: manager.password.value!),
                        child: const Text('Zaloguj się'))
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (!manager.isEmailAndPasswordValid)
                        ? null : () =>
                        manager.register(
                            email: manager.email.value!, password: manager.password.value!),
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
              icon: Image.asset(
                'assets/images/general/g-logo.png',
                height: 22,
                width: 22,
              ),
              label: const Text('Zaloguj się przez Google'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                context.read<Manager>().navigate(Screen.resetPassword);
              },
              child: const Text(
                'Nie pamiętasz hasła?',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),

            // //if there's message in manager, show dialog
            // if (manager.infoMsg.isNotEmpty) MessageDialog(msg: manager.infoMsg),
          ],
        ),
      ),
    );
  }
}
