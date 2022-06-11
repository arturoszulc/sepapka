import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/custom_widgets/build_question.dart';

import '../../model_layer/models/question.dart';
import '../../utils/consts/nav.dart';
import '../../viewmodel_layer/manager.dart';
import '../../utils/custom_widgets/snackbar_hide_question.dart';

class QuestionListSingle extends StatelessWidget {
  const QuestionListSingle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** QuestionListSingle Screen built ***');
    // ScaffoldMessenger.of(context).clearSnackBars();
    // final manager = Provider.of<Manager>(context);
    final int index = Provider.of<Manager>(context).qListGlobalFilteredIndex;
    final int filteredListLength = context.read<Manager>().qListGlobalFiltered.length - 1;
    Question? question = context.read<Manager>().getSingleFilteredQuestion();
    final bool isQuestionHidden = context.read<Manager>().isQuestionHidden(question?.id);

    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(MyScreen.listQuestion),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.read<Manager>().navigate(MyScreen.listQuestion),
          ),
          title: Text('Pytanie ${index + 1} / ${filteredListLength + 1}'),
          centerTitle: true,
          actions: [
            isQuestionHidden ?
            IconButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  await context.read<Manager>().moveQuestionBackToShown();
                  ScaffoldMessenger.of(context).showSnackBar(snackBarShowHide(msg: 'Pytanie będzie widoczne'));
                },
                icon: const Icon(Icons.visibility_off)) :
                IconButton(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      await context.read<Manager>().doNotShowThisQuestionAnymore();
                      ScaffoldMessenger.of(context).showSnackBar(snackBarShowHide(msg: 'Pytanie zostało ukryte'));
                    },
                    icon: const Icon(Icons.visibility)),
            // buildSettingsMenu(isQuestionHidden),
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
                  context.read<Manager>().showSingleFilteredQuestion(index - 1);
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
                  context.read<Manager>().showSingleFilteredQuestion(index + 1);
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
