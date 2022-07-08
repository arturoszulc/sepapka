import 'package:flutter/material.dart';



class AnswerButton extends StatelessWidget {
  // final QuestionStatus qStatus;
  final String? answer;
  final Color color;
  final VoidCallback onSelected;

  const AnswerButton({Key? key, this.answer, required this.color, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding( //to keep buttons separated
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 40.0,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color,
          ),
          onPressed: () {
            // if (qStatus == QuestionStatus.noAnswer) {
              onSelected();
            // }
          },
          // minWidth: 300,
          // color: color,
          child: Text(answer!, textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}