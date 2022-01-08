import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/model_layer/models/answer_map.dart';
import 'package:sepapka/model_layer/question.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import 'custom_widgets/answer_button.dart';

class QuestionSingleScreen extends StatelessWidget {
  QuestionSingleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** QuestionSingleScreen built ***');
    final manager = Provider.of<Manager>(context);
    Question? question = manager.singleKnownQuestion;
    List<AMap> aMapList = manager.aMapList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Single question'),
      ),
      body: question == null
          ? const Center(
              child: Text('NO QUESTION FOUND'),
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
                        manager.isAnswered.toString(),
                        // maxLines: 3,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnswerButton(
                          isActive: manager.isAnswered,
                          answer: aMapList[0].answer,
                          color: aMapList[0].color,
                          onSelected: () {
                            manager.checkAnswer(aMapList[0].answer);
                          },
                        ),
                        AnswerButton(
                          isActive: manager.isAnswered,
                          answer: aMapList[1].answer,
                          color: aMapList[1].color,
                          onSelected: () {
                            manager.checkAnswer(aMapList[1].answer);
                          },
                        ),
                        AnswerButton(
                          isActive: manager.isAnswered,
                          answer: aMapList[2].answer,
                          color: aMapList[2].color,
                          onSelected: () {
                            manager.checkAnswer(aMapList[2].answer);
                          },
                        ),
                        AnswerButton(
                          isActive: manager.isAnswered,
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
      floatingActionButton: manager.isAnswered ? FloatingActionButton.extended(
          onPressed: () async {
            await context.read<Manager>().prepareNewQuestion();
            Navigator.pushReplacementNamed(context, '/question-single');
          },
          label: Text('Dobrze!'),
      ): null,
    );
  }


}
