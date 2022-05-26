import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/utils/custom_widgets/sign_in_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import '../../utils/consts/colors.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  // final TextEditingController emailFieldController = TextEditingController();
  final _resetForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    debugPrint('*** ResetPasswordScreen build ***');

    //clear field on rebuild
    // emailFieldController.clear();
    final manager = Provider.of<Manager>(context);
    final errorMsg = manager.errorMsg;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // final error = context.read<Manager>().errorMsg;
    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(Screen.signIn),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.read<Manager>().navigate(Screen.signIn),
          ),
          title: const Text('Reset hasła'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(
            children: [
              Form(
                key: _resetForm,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),

                    //pole EMAIL
                    TextFormField(
                      initialValue: manager.emailRemind.value,
                      // controller: emailFieldController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'Adres e-mail',
                        errorText: manager.emailRemind.error,
                      ),
                      onChanged: (val) {
                        manager.validateEmailRemind(val);
                      },
                      onTap: () => manager.setError(null),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // const Text(
              //     'Na podany niżej adres e-mail zostanie wysłany link do zresetowania hasła'),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  errorMsg,
                  style: TextStyle(color: isDarkMode ? flexSchemeDark.error : flexSchemeLight.error),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 10.0),
              SignInButton(
                  onPressed: (manager.emailRemind.value == null)
                      ? null
                      : () async {
                          await manager.resetPassword(manager.emailRemind.value!);
                        },
                  label: 'Resetuj hasło'),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
