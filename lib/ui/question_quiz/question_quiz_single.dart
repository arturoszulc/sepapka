import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/controllers/quiz_controller.dart';
import 'package:sepapka/models/button_map.dart';
import 'package:sepapka/models/question.dart';
import 'package:sepapka/utils/custom_widgets/dialog_leave_session.dart';

import '../../utils/consts/my_screens.dart';
import '../../utils/custom_widgets/build_question.dart';
import '../../utils/custom_widgets/buttons/answer_button.dart';
import '../../utils/custom_widgets/single_question_top_bar.dart';

class QuizSingleQuestion extends ConsumerWidget {
  const QuizSingleQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** QuestionSingleScreen built ***');
    // final myManager = ref.read(manager);
    final bool isAnswered = ref.watch(isQuestionAnswered);
    final Question question = ref.watch(quizCurrentQuestion);
    final List<BMap> bMapList = ref.watch(bMapProvider);
    debugPrint('QUIZ IS ANSWERED: $isAnswered');

    return WillPopScope(
      onWillPop: () async {
        bool result = await leaveSessionDialog(context);
        if (result) {
          context.goNamed(MyScreen.menu.name);
        }
        return false;
      },
      child: SafeArea(
        //question single screen is made of:
        // - top bar with progress indicator and other things
        // - main area with questions and aswers
        child: Scaffold(
          body: Column(mainAxisSize: MainAxisSize.min, children: [
            //build topBar
            singleQuestionTopBar(context),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(flex: 7, child: buildQuestion(context, question)),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: bMapList
                    .map((e) => AnswerButton(
                        answer: e.answer,
                        color: e.color,
                        onSelected: () {
                          ref.read(quizController).checkAnswer(e.answer);
                        }))
                    .toList(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ]),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Visibility(
            visible: isAnswered ? true : false,
            child: FloatingActionButton.extended(
              onPressed: () {
                ref.read(quizController).nextQuestion();
              },
              label: const Text('Dalej >'),
            ),
          ),
        ),
      ),
    );
  }
}
