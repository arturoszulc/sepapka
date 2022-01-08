import 'package:flutter/material.dart';



class AnswerButton extends StatelessWidget {
  final bool isActive;
  final String? answer;
  final Color color;
  final VoidCallback onSelected;

  const AnswerButton({Key? key, required this.isActive, this.answer, required this.color, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () {
          if (!isActive) {
            onSelected();
          }
        },
        minWidth: 300,
        height: 45.0,
        color: color,
        child: Text(answer!),
      ),
    );
  }
}