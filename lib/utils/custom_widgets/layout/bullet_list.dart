import 'package:flutter/material.dart';

class LessonList extends StatelessWidget {
  final List<String> strings;
  final List<String> customBullets;
  final bool bullets;
  final bool numbers;
  static const TextStyle bulletListStyle = TextStyle(
    // fontSize: 16,
    // color: Colors.black87,
    height: 1.55,
  );

  const LessonList(
      {Key? key,
      required this.strings,
      this.customBullets = const [],
      this.bullets = false,
      this.numbers = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
          customBullets.isNotEmpty ?
              '${customBullets[strings.indexOf(str)]} - ' : bullets ?
          '\u2022' : numbers ?
          '${strings.indexOf(str) + 1}.' : '',
          textAlign: TextAlign.right, style: bulletListStyle,),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(str, textAlign: TextAlign.left, softWrap: true, style: bulletListStyle),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
