import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final List<String> strings;
  final bool bullets;
  final bool numbers;
  static const TextStyle bulletListStyle = TextStyle(
    // fontSize: 16,
    // color: Colors.black87,
    height: 1.55,
  );
  const CustomList({Key? key, required this.strings, this.bullets = false, this.numbers = false}) : super(key: key);

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
              bullets ?
              const Text('\u2022', style: bulletListStyle) :
                  numbers ?
                  Text('${strings.indexOf(str) + 1}.', style: bulletListStyle,) : Container(),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  str,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: bulletListStyle
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
