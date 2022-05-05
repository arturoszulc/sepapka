import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/nav.dart';




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
    final error = manager.errorMsg;
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
              const Text('Na podany niżej adres e-mail zostanie wysłany link do zresetowania hasła'),
              Form(
                key: _resetForm,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),

                    //pole EMAIL
                    TextFormField(
                      // controller: emailFieldController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'Adres e-mail',
                        errorText: manager.emailRemind.error,
                      ),
                      onChanged: (val) {
                        manager.validateEmailRemind(val);
                      },
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () async {
                  await manager.resetPassword(email);
                  // if (result != null) {
                  //   Navigator.of(context).pushNamedAndRemoveUntil(
                  //     '/wrapper', (Route<dynamic> route) => false);
                  // }
                },
                child: const Text('Resetuj hasło'),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );

  }
}
