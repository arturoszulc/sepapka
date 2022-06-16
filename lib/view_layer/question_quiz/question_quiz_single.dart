import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/utils/consts/question.dart';
import 'package:sepapka/utils/custom_widgets/dialog_leave_session.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import '../../utils/custom_widgets/buttons/answer_button.dart';
import '../../utils/custom_widgets/build_question.dart';
import '../../utils/custom_widgets/single_question_top_bar.dart';

class QuizSingleQuestion extends ConsumerWidget {
  const QuizSingleQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** QuestionSingleScreen built ***');
    final myManager = ref.read(manager);
    Question? question = myManager.currentQuestion;
    List<BMap> aMapList = myManager.bMapList;

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
                        children: [
                      AnswerButton(
                        qStatus: myManager.qStatus,
                        answer: aMapList[0].answer,
                        color: aMapList[0].color,
                        onSelected: () {
                          myManager.checkAnswer(aMapList[0].answer);
                        },
                      ),
                      AnswerButton(
                        qStatus: myManager.qStatus,
                        answer: aMapList[1].answer,
                        color: aMapList[1].color,
                        onSelected: () {
                          myManager.checkAnswer(aMapList[1].answer);
                        },
                      ),
                      AnswerButton(
                        qStatus: myManager.qStatus,
                        answer: aMapList[2].answer,
                        color: aMapList[2].color,
                        onSelected: () {
                          myManager.checkAnswer(aMapList[2].answer);
                        },
                      ),
                      AnswerButton(
                        qStatus: myManager.qStatus,
                        answer: aMapList[3].answer,
                        color: aMapList[3].color,
                        onSelected: () {
                          myManager.checkAnswer(aMapList[3].answer);
                        },
                      ),
                    ]),
                  ),
            Expanded(flex: 2, child: Container(),),
                ]),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Visibility(
            visible: myManager.qStatus == QuestionStatus.noAnswer ? false : true,
            child: FloatingActionButton.extended(
              onPressed: () async {
                await myManager.getNextQuizQuestion();
              },
              label: const Text('Dalej >'),
            ),
          ),
        ),
      ),
    );
  }
}
