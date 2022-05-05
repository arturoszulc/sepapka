import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/utils/custom_widgets/sign_in_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  // final TextEditingController emailFieldController = TextEditingController();
  final _resetForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    debugPrint('*** ResetPasswordScreen build ***');
    String email = '';

    //clear field on rebuild
    // emailFieldController.clear();
    final manager = Provider.of<Manager>(context);
    final errorMsg = manager.errorMsg;
    // final error = context.read<Manager>().errorMsg;
    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(Screen.signIn),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.read<Manager>().navigate(Screen.signIn),
          ),
          title: const Text('Zresetuj hasło'),
          centerTitle: true,
          // title: const Text('Sign In Screen'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(
            children: [
              const Text(
                  'Na podany niżej adres e-mail zostanie wysłany link do zresetowania hasła'),
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
                      onTap: () => manager.hideError(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  errorMsg,
                  style: TextStyle(color: Colors.grey[700]),
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
