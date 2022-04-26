import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model_layer/models/question.dart';
import '../../viewmodel_layer/manager.dart';



Widget buildQuestion(BuildContext context, Question? question) {
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
        child: context.read<Manager>().getImage(question.assetPath) ?? Container(),
        // child: question.assetPath.isEmpty ? Container() :
        // Image.asset('assets/images/questions/${question.assetPath}'),
      ),
    ],
  );

}
