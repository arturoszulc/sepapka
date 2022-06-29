import 'package:flutter/material.dart';

class CustomParagraph extends StatelessWidget {
  const CustomParagraph({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    List<String> splittedText = text.split('*');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text.rich(TextSpan(
        children: List<TextSpan>.from([
          for (final text in splittedText)
            ...[TextSpan(text: text, style: splittedText.indexOf(text).isEven ? null : const TextStyle(fontWeight: FontWeight.bold))]
        ])
      )),
    );
  }
}
