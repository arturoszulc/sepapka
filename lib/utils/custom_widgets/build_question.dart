import 'package:flutter/material.dart';
import 'package:sepapka/utils/custom_widgets/build_question_image.dart';
import 'package:sepapka/utils/custom_widgets/image_full_screen.dart';

import '../../model_layer/models/question.dart';



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
        child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ImageFullScreen(imagePath: question.assetPath);
              }),);
            },
            child: Hero(
                tag: 'imageHero',
                child: buildQuestionImage(question.assetPath) ?? Container())),
        // child: question.assetPath.isEmpty ? Container() :
        // Image.asset('assets/images/questions/${question.assetPath}'),
      ),
    ],
  );

}
