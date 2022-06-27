import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/utils/custom_widgets/build_question.dart';
import 'package:sepapka/viewmodel_layer/question_list_controller.dart';

import '../../model_layer/models/question.dart';
import '../../utils/custom_widgets/snackbar_hide_question.dart';

class QuestionListSingle extends ConsumerWidget {
  const QuestionListSingle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** QuestionListSingle Screen built ***');
    // final myManager = ref.read(manager);
    final int index = ref.watch(qListCurrentQuestionIndex);
    final int filteredListLength = ref.watch(qListFiltered).length - 1;
    final Question question = ref.watch(qListCurrentQuestion);
    final bool isQuestionHidden = ref.read(questionListController).isQuestionHidden(question.id);
    final bool isQuestionEmpty = question.id == ''; //if there's no more question to show
    return Scaffold(
      appBar: AppBar(
        title: Text(
            isQuestionEmpty ? 'Brak pytań' : 'Pytanie ${index + 1} / ${filteredListLength + 1}'),
        centerTitle: true,
        actions: [
          isQuestionEmpty ? Container() : //if no question, do not show Icon button
          isQuestionHidden //if there's a question, show IconButton according to visibility
              ? IconButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ref.read(questionListController).removeQuestionFromHidden(question.id);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(buildSnackBar(msg: 'Pytanie będzie widoczne'));
                  },
                  icon: const Icon(Icons.visibility_off))
              : IconButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ref.read(questionListController).moveQuestionToHidden(question.id);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(buildSnackBar(msg: 'Pytanie zostało ukryte'));
                  },
                  icon: const Icon(Icons.visibility)),
          // buildSettingsMenu(isQuestionHidden),
        ],
      ),
      body: isQuestionEmpty
          ? Container()
          : Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  flex: 3,
                  child: buildQuestion(context, question),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Odpowiedź:',
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                      // const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                        child: Text(
                          question.a1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: isQuestionEmpty
          ? Container()
          : Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(
                Icons.navigate_before_outlined,
                size: 40,
              ),
              onPressed: index == 0
                  ? null
                  : () {
                      ref.read(questionListController).previousQuestion();
                    },
            ),
            IconButton(
              icon: const Icon(
                Icons.navigate_next_outlined,
                size: 40,
              ),
              onPressed: index == filteredListLength
                  ? null
                  : () {
                      ref.read(questionListController).nextQuestion();
                    },
            ),
          ],
        ),
      ),
    );
  }
}
