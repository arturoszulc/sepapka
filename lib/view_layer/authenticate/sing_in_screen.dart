import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/model_layer/models/input_validation_model.dart';
import 'package:sepapka/utils/consts/colors.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/viewmodel_layer/auth_controller.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import '../../viewmodel_layer/route_controller.dart';

class SignInScreen extends ConsumerWidget {
  SignInScreen({Key? key}) : super(key: key);
  final _authFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** SignInScreen built ***');
    final _authController = ref.read(authController);
    final _authError = ref.watch(authErrorState);
    final InputValidationModel _email = ref.watch(emailState);
    final InputValidationModel _password = ref.watch(passwordState);
    final bool isEmailAndPasswordValid = ref.watch(authController).isEmailAndPasswordValid;
    // final myManager = ref.read(manager);
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
                      initialValue: _email.value,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Adres e-mail',
                        errorText: _email.error,
                      ),
                      onChanged: (String val) {
                        _authController.validateEmail(val);
                      },
                      onTap: () => _authController.setAuthError(null),
                    ),
                  ),

                  //pole PASSWORD
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      initialValue: _password.value,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Hasło',
                        errorText: _password.error,
                        errorMaxLines: 2,
                      ),
                      onChanged: (String val) {
                        _authController.validatePassword(val);
                      },
                      onTap: () => _authController.setAuthError(null),
                    ),
                  ),
                ],
              ),
            ),

            //Auth error display
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 5.0),
                child: Text(
                  _authError,
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
                    child: ElevatedButton(onPressed: (!isEmailAndPasswordValid)
                        ? null : () =>
                        _authController.signIn(),
                        child: const Text('Zaloguj się'))
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (!isEmailAndPasswordValid)
                        ? null : () =>
                        _authController.register(),
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
                _authController.signInWithGoogle();
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
                ref.read(routeController).navigate(MyScreen.resetPassword);
                // myManager.navigate(MyScreen.resetPassword);
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
