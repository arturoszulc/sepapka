import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/utils/consts/question.dart';
import 'package:sepapka/view_layer/custom_widgets/dialog_leave_session.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import '../custom_widgets/answer_button.dart';
import '../custom_widgets/build_question.dart';
import '../custom_widgets/single_question_top_bar.dart';

class QuestionQuizSingle extends StatelessWidget {
  const QuestionQuizSingle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** QuestionSingleScreen built ***');
    final manager = Provider.of<Manager>(context);
    Question? question = manager.currentQuestion;
    List<BMap> aMapList = manager.bMapList;

    return WillPopScope(
      onWillPop: () async {
      bool result = await leaveSessionDialog(context);
      if (result) {
        context.read<Manager>().interruptSession();
        return false;
      }
        return false;
        // context.read<Manager>().navigate(Screen.menu);
      },
    child: SafeArea(

        //question single screen is made of:
        // - top bar with progress indicator and other things
        // - main area with questions and aswers
        child: Scaffold(
          body: Column(mainAxisSize: MainAxisSize.min, children: [
                //build topBar
                  singleQuestionTopBar(context),
                  const SizedBox(height: 10.0,),
                  Expanded(
                      flex: 3,
                      child: buildQuestion(question)),
                  Expanded(
                    flex: 6,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      AnswerButton(
                        qStatus: manager.qStatus,
                        answer: aMapList[0].answer,
                        color: aMapList[0].color,
                        onSelected: () {
                          manager.checkAnswer(aMapList[0].answer);
                        },
                      ),
                      AnswerButton(
                        qStatus: manager.qStatus,
                        answer: aMapList[1].answer,
                        color: aMapList[1].color,
                        onSelected: () {
                          manager.checkAnswer(aMapList[1].answer);
                        },
                      ),
                      AnswerButton(
                        qStatus: manager.qStatus,
                        answer: aMapList[2].answer,
                        color: aMapList[2].color,
                        onSelected: () {
                          manager.checkAnswer(aMapList[2].answer);
                        },
                      ),
                      AnswerButton(
                        qStatus: manager.qStatus,
                        answer: aMapList[3].answer,
                        color: aMapList[3].color,
                        onSelected: () {
                          manager.checkAnswer(aMapList[3].answer);
                        },
                      ),
                    ]),
                  ),
                ]),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // FloatingActionButton(
              //     heroTag: 'exit',
              //     onPressed: () {
              //       Navigator.of(context)
              //           .pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
              //     },
              //     child: const Icon(Icons.exit_to_app)),
              Visibility(
                visible: manager.qStatus == QuestionStatus.noAnswer ? false : true,
                child: FloatingActionButton.extended(
                  heroTag: 'next',
                  onPressed: () async {
                    await context.read<Manager>().getNextQuizQuestion();
                  },
                  label: const Text('Dalej >'),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
