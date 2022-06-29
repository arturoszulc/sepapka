import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({Key? key, required this.title}) : super(key: key);

  final String title;
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 18,
    // color: Colors.black87,
    height: 1.55,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: headerTextStyle,),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 3,
          width: 30,
          color: Colors.grey[300],
        )
      ],
    );
  }
}
