import 'package:flutter/material.dart';
import 'package:sepapka/utils/consts.dart';



class AnswerButton extends StatelessWidget {
  final QuestionStatus qStatus;
  final String? answer;
  final Color color;
  final VoidCallback onSelected;

  const AnswerButton({Key? key, required this.qStatus, this.answer, required this.color, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 30.0,
      ),
      child: MaterialButton(
        onPressed: () {
          if (qStatus == QuestionStatus.noAnswer) {
            onSelected();
          }
        },
        minWidth: 300,
        height: 50.0,
        color: color,
        child: Text(answer!),
      ),
    );
  }
}