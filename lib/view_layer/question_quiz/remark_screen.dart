import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/utils/custom_widgets/sign_in_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class RemarkScreen extends StatelessWidget {
  RemarkScreen({Key? key}) : super(key: key);
  String remark = '';

  @override
  Widget build(BuildContext context) {
    debugPrint('*** RemarkScreen built ***');
    final manager = Provider.of<Manager>(context);
    Question currentQuestion = manager.currentQuestion!;
    final error = manager.errorMsg;

    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(Screen.quizQuestionSingle),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.read<Manager>().navigate(Screen.quizQuestionSingle),
            ),
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
                    initialValue: manager.remark.value,
                    textInputAction: TextInputAction.done,
                    // expands: true,
                    maxLines: 6,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      errorText: manager.remark.error,
                    ),
                    // hintText: ,
                    onChanged: (String val) {
                      manager.validateRemark(val);
                    },
                    onTap: () => manager.hideError(),
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
                  child: SignInButton(
                    onPressed: (manager.remark.value == null)
                        ? null
                        : () => manager.sendQuestionRemark(),
                    label: 'Wyślij uwagę',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
