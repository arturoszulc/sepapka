import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/viewmodel_layer/auth_controller.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import '../../model_layer/models/input_validation_model.dart';
import '../../utils/consts/colors.dart';
import '../../utils/custom_widgets/dialog_message.dart';

class ResetPasswordScreen extends ConsumerWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  final _resetForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** ResetPasswordScreen build ***');

    final _authController = ref.read(authController);
    final String emailRemindError = ref.watch(emailRemindErrorState);
    final InputValidationModel _email = ref.watch(emailState);
    final bool isEmailRemindSent = ref.watch(emailRemindSent);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
                    initialValue: _email.value,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Adres e-mail',
                      errorText: _email.error,
                    ),
                    onChanged: (val) {
                      _authController.validateEmail(val);
                    },
                    onTap: () => _authController.setEmailRemindError(null),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                emailRemindError,
                style: TextStyle(color: isDarkMode ? flexSchemeDark.error : flexSchemeLight.error),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
                onPressed: (_email.value == null || isEmailRemindSent)
                    ? null
                    : () async {
                        await ref.read(authController).resetPassword();
                        //poniżej musi zostać ref.read i nie można korzystać z przebudowywanego isEmailRemindSent!!!
                        if (ref.read(emailRemindSent)) return buildMessageDialog(context, 'Link do zresetowania hasła został wysłany na podany adres e-mail');
                      },
                child: const Text('Resetuj hasło')),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
