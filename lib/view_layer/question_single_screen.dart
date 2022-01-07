import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/model_layer/question.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import 'custom_widgets/answer_button.dart';

class QuestionSingleScreen extends StatelessWidget {
  const QuestionSingleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<Manager>(context);
    Question? question = manager.singleKnownQuestion;
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
                    padding: EdgeInsets.all(15.0),
                    alignment: Alignment.bottomLeft,
                    child: Card(
                      child: Text(
                        question.q,
                        maxLines: 3,
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
                          answer: question.a1,
                          onSelected: () {},
                        ),
                        AnswerButton(
                          answer: question.a2,
                          onSelected: () {},
                        ),
                        AnswerButton(
                          answer: question.a3,
                          onSelected: () {},
                        ),
                        AnswerButton(
                          answer: question.a4,
                          onSelected: () {},
                        ),
                      ]),
                ),
              ]),
            ),
    );
  }


}
