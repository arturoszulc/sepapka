import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';



class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  TextEditingController emailFieldController = TextEditingController();
  final _resetForm = GlobalKey<FormState>();
  String email = '';
  String? error;

  @override
  Widget build(BuildContext context) {
    debugPrint('*** ResetPasswordScreen build');

    //clear field on rebuild
    emailFieldController.clear();
    final manager = Provider.of<Manager>(context);
    return Scaffold(
      appBar: AppBar(
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
                    controller: emailFieldController,
                    textInputAction: TextInputAction.next,
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
                manager.errorMsg != null ? manager.errorMsg.toString() : '',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                manager.resetPassword(email);
              },
              child: const Text('Resetuj hasło'),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );

  }
}
