import 'package:flutter/material.dart';

class LessonFunFact extends StatelessWidget {
  const LessonFunFact({Key? key, required this.text}) : super(key: key);

  final String text;

  static const TextStyle funFactStyle = TextStyle(fontStyle: FontStyle.italic);

  @override
  Widget build(BuildContext context) {
    List<String> splittedText = text.split('*');
    return Card(
        elevation: 4,
        child: Row(
          children: [
            const Expanded(child: Icon(Icons.flash_on)),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                child: Text.rich(
                    TextSpan(
                  style: funFactStyle,
                    children: List<TextSpan>.from([
                      for (final text in splittedText)
                        ...[TextSpan(text: text, style: splittedText.indexOf(text).isEven ? null : const TextStyle(fontWeight: FontWeight.bold))]
                    ])
                )),
              ),
            ),
          ],
        ),
      );
  }
}


class LessonFunFact2 extends StatelessWidget {
  const LessonFunFact2({Key? key, required this.text}) : super(key: key);

  final String text;

  static const TextStyle funFactHeaderStyle = TextStyle(fontStyle: FontStyle.italic);
  static const TextStyle funFactBodyStyle = TextStyle(fontStyle: FontStyle.italic,);

  @override
  Widget build(BuildContext context) {
    List<String> splittedText = text.split('*');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.flash_on),
                  Text('  Czy wiesz, że...', style: Theme.of(context).textTheme.bodyLarge,)
                ],
              ),
              const SizedBox(height: 10,),
              Text.rich(
                  TextSpan(
                      style: funFactBodyStyle,
                      children: List<TextSpan>.from([
                        for (final text in splittedText)
                          ...[TextSpan(text: text, style: splittedText.indexOf(text).isEven ? null : const TextStyle(fontWeight: FontWeight.bold))]
                      ])
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

