import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/utils/custom_widgets/buttons/sign_in_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class RemarkScreen extends ConsumerWidget {
  RemarkScreen({Key? key}) : super(key: key);
  String remark = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** RemarkScreen built ***');
    final myManager = ref.read(manager);
    Question currentQuestion = myManager.currentQuestion!;
    final error = myManager.errorMsg;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Prześlij uwagę'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Uwaga dotyczy pytania:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(currentQuestion.q),
              const SizedBox(
                height: 20.0,
              ),
              Text('A: ${currentQuestion.a1}'),
              Text('B: ${currentQuestion.a2}'),
              Text('C: ${currentQuestion.a3}'),
              Text('D: ${currentQuestion.a4}'),
              const SizedBox(height: 50),
              const Text(
                'Treść uwagi:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  initialValue: myManager.remark.value,
                  textInputAction: TextInputAction.done,
                  // expands: true,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(),
                    errorText: myManager.remark.error,
                  ),
                  // hintText: ,
                  onChanged: (String val) {
                    myManager.validateRemark(val);
                  },
                  onTap: () => myManager.setError(null),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: (myManager.remark.value == null)
                      ? null
                      : () => myManager.sendQuestionRemark(),
                  child: const Text('Wyślij uwagę'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
