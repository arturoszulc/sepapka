import 'package:flutter/material.dart';
import 'package:sepapka/utils/consts/question.dart';



class AnswerButton extends StatelessWidget {
  final QuestionStatus qStatus;
  final String? answer;
  final Color color;
  final VoidCallback onSelected;

  const AnswerButton({Key? key, required this.qStatus, this.answer, required this.color, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding( //to keep buttons separated
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        // horizontal: 30.0,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.7,
        height: 55.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color,
          ),
          onPressed: () {
            if (qStatus == QuestionStatus.noAnswer) {
              onSelected();
            }
          },
          // minWidth: 300,
          // color: color,
          child: Text(answer!, textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}