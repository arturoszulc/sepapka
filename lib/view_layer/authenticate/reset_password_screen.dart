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
    final error = Provider.of<Manager>(context).errorMsg;
    // final error = context.read<Manager>().errorMsg;
    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(Screen.signIn),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.read<Manager>().navigate(Screen.signIn),
          ),
          title: Text('Zresetuj hasło'),
          centerTitle: true,
          // title: const Text('Sign In Screen'),
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
                      // controller: emailFieldController,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: 'Adres e-mail',
                      ),
                      onChanged: (val) {
                        email = val;
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
                  await context.read<Manager>().resetPassword(email);
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
