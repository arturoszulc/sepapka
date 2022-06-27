import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/model_layer/services/validation_service.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/viewmodel_layer/remark_controller.dart';

import '../../model_layer/models/input_validation_model.dart';
import '../../utils/custom_widgets/dialog_message.dart';
import '../../utils/custom_widgets/snackbar_hide_question.dart';
import '../../viewmodel_layer/quiz_controller.dart';

class RemarkScreen extends ConsumerWidget {
  RemarkScreen({Key? key}) : super(key: key);
  String remark = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** RemarkScreen built ***');
    // final myManager = ref.read(manager);
    final InputValidationModel _remark = ref.watch(remarkState);
    final Question currentQuestion = ref.watch(quizCurrentQuestion);
    final error = ref.watch(remarkErrorState);

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
                  initialValue: _remark.value,
                  textInputAction: TextInputAction.done,
                  // expands: true,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(),
                    errorText: _remark.error,
                  ),
                  // hintText: ,
                  onChanged: (String val) {
                    ref.read(remarkController).validateRemark(val);
                  },
                  onTap: () => ref.read(remarkController).setRemarkError(null),
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
                  onPressed: (_remark.value == null)
                      ? null
                      : () async {
                    ref.read(remarkController).sendRemark();
                    context.pop();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(buildSnackBar(msg: 'Uwaga została wysłana'));
                  },
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
