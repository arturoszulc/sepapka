import 'package:flutter/material.dart';

class CustomFunFact extends StatelessWidget {
  const CustomFunFact({Key? key, required this.text}) : super(key: key);

  final String text;

  static const TextStyle funFactStyle = TextStyle(fontStyle: FontStyle.italic);

  @override
  Widget build(BuildContext context) {
    List<String> splittedText = text.split('*');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Row(
          children: [
            const Expanded(child: Icon(Icons.flash_on)),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
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
      ),
    );
  }
}
