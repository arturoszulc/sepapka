import 'package:flutter/material.dart';

import '../../model_layer/models/question.dart';



Widget buildQuestion(Question? question) {
  return question == null ? Container() :
  Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
        child: Text(
          question.q,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          // maxLines: 3,
        ),
      ),
      Expanded(
        child: question.assetPath.isEmpty ? Container() :
        Image.asset('assets/images/questions/${question.assetPath}',

        ),
      ),
    ],
  );

}