import 'package:flutter/material.dart';



class AnswerButton extends StatelessWidget {
  final String answer;
  final VoidCallback onSelected;

  const AnswerButton({Key? key, required this.answer, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () {
          onSelected();
        },
        minWidth: 300,
        height: 45.0,
        color: Colors.yellow,
        child: Text(answer),
      ),
    );
  }
}