import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/model_layer/models/quiz_state_model.dart';
import 'package:sepapka/utils/consts/question.dart';
import 'package:sepapka/utils/custom_widgets/dialog_leave_session.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/viewmodel_layer/quiz_controller.dart';

import '../../utils/custom_widgets/buttons/answer_button.dart';
import '../../utils/custom_widgets/build_question.dart';
import '../../utils/custom_widgets/single_question_top_bar.dart';

class QuizSingleQuestion extends ConsumerWidget {
  const QuizSingleQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** QuestionSingleScreen built ***');
    final myManager = ref.read(manager);
    final myQuizController = ref.watch(quizController);
    Question question = ref.read(quizController.notifier).currentQuestion;
    List<BMap> bMapList = ref.watch(bMapProvider);


    return WillPopScope(
      onWillPop: () async {
      bool result = await leaveSessionDialog(context);
      if (result) {
        myManager.interruptSession();
        return false;
      }
        return false;
        // context.read<Manager>().navigate(Screen.menu);
      },
    child: SafeArea(
      // maintainBottomViewPadding: true,

        //question single screen is made of:
        // - top bar with progress indicator and other things
        // - main area with questions and aswers
        child: Scaffold(
          body: Column(mainAxisSize: MainAxisSize.min, children: [
                //build topBar
                  singleQuestionTopBar(context),
                  const SizedBox(height: 10.0,),
                  Expanded(
                      flex: 7,
                      child: buildQuestion(context, question)),
                  Expanded(
                    flex: 8,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: bMapList.map((e) =>
                        AnswerButton(
                            qStatus: myManager.qStatus,
                            answer: e.answer,
                            color: e.color,
                            onSelected: () {
                              ref.read(quizController.notifier).checkAnswer(e.answer);
                            })
                        ).toList(),
                        
                    //   children:  [
                    //   AnswerButton(
                    //     qStatus: myManager.qStatus,
                    //     answer: bMapList[0].answer,
                    //     color: bMapList[0].color,
                    //     onSelected: () {
                    //       myManager.checkAnswer(bMapList[0].answer);
                    //     },
                    //   ),
                    //   AnswerButton(
                    //     qStatus: myManager.qStatus,
                    //     answer: bMapList[1].answer,
                    //     color: bMapList[1].color,
                    //     onSelected: () {
                    //       myManager.checkAnswer(bMapList[1].answer);
                    //     },
                    //   ),
                    //   AnswerButton(
                    //     qStatus: myManager.qStatus,
                    //     answer: bMapList[2].answer,
                    //     color: bMapList[2].color,
                    //     onSelected: () {
                    //       myManager.checkAnswer(bMapList[2].answer);
                    //     },
                    //   ),
                    //   AnswerButton(
                    //     qStatus: myManager.qStatus,
                    //     answer: bMapList[3].answer,
                    //     color: bMapList[3].color,
                    //     onSelected: () {
                    //       myManager.checkAnswer(bMapList[3].answer);
                    //     },
                    //   ),
                    // ]
                    
                    ),
                  ),
            Expanded(flex: 2, child: Container(),),
                ]),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Visibility(
            visible: myQuizController.status == QuizStatus.answered ? true : false,
            child: FloatingActionButton.extended(
              onPressed: () {
                ref.read(quizController.notifier).nextQuestion();
              },
              label: const Text('Dalej >'),
            ),
          ),
        ),
      ),
    );
  }
}
