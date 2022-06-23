import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/utils/custom_widgets/build_question.dart';
import 'package:sepapka/viewmodel_layer/question_list_controller.dart';

import '../../model_layer/models/question.dart';
import '../../utils/consts/my_screens.dart';
import '../../viewmodel_layer/manager.dart';
import '../../utils/custom_widgets/snackbar_hide_question.dart';

class QuestionListSingle extends ConsumerWidget {
  const QuestionListSingle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** QuestionListSingle Screen built ***');
    // final myManager = ref.read(manager);
    final int index = ref.watch(questionListIndex);
    final int filteredListLength = ref.watch(filteredQuestionList).length - 1;
    final Question question = ref.watch(questionListCurrentQuestion(index));

    return Scaffold(
      appBar: AppBar(
        title: Text('Pytanie ${index + 1} / ${filteredListLength + 1}'),
        centerTitle: true,
        actions: [
          Consumer(builder: (context, ref, child) =>
          ref.watch(questionListController).isQuestionHidden(question.id) ?
          IconButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ref.read(questionListController).removeQuestionFromHidden();
                ScaffoldMessenger.of(context).showSnackBar(snackBarShowHide(msg: 'Pytanie będzie widoczne'));
              },
              icon: const Icon(Icons.visibility_off)) :
              IconButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ref.read(questionListController).moveQuestionToHidden();
                    ScaffoldMessenger.of(context).showSnackBar(snackBarShowHide(msg: 'Pytanie zostało ukryte'));
                  },
                  icon: const Icon(Icons.visibility)),
          // buildSettingsMenu(isQuestionHidden),
          ),
        ],
      ),
      body: question == null
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
      floatingActionButton: Padding(
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
