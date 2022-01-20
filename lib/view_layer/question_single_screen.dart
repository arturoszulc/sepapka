import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import 'custom_widgets/answer_button.dart';

class QuestionSingleScreen extends StatelessWidget {
  const QuestionSingleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** QuestionSingleScreen built ***');
    final manager = Provider.of<Manager>(context);
    Question? question = manager.currentQuestion;
    List<BMap> aMapList = manager.bMapList;
    return Scaffold(
      body: question == null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Brak nowych pytań'),
                  const SizedBox(height: 20.0),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     },
                  //     child: const Text('Powrót'))
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    alignment: Alignment.bottomLeft,
                    child: Card(
                      child: Text(
                        question.id,
                        // maxLines: 3,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          FloatingActionButton(
            heroTag: 'exit',
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/wrapper', (Route<dynamic> route) => false);
              },
              child: const Icon(Icons.exit_to_app)),

          Visibility(
            visible: manager.qStatus == QuestionStatus.noAnswer ? false : true,
            child: FloatingActionButton.extended(
              heroTag: 'next',
              onPressed: () async {
                await context.read<Manager>().getNextQuestion();
                Navigator.pushReplacementNamed(context, '/question-single');
              },
              label: const Text('Dalej >'),
            ),
          ),
        ]),
      ),
    );
  }
}
