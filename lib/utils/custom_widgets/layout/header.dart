import 'package:flutter/material.dart';

class LessonHeader extends StatelessWidget {
  const LessonHeader({Key? key, required this.title}) : super(key: key);

  final String title;
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 18,
    // height: 1.55,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
      child: Column(
        children: [
          Text(title, style: headerTextStyle,),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 3,
            width: 30,
            color: Colors.grey[300],
          )
        ],
      ),
    );
  }
}
