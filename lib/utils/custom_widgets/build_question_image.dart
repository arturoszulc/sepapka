import 'package:flutter/material.dart';


Widget? buildQuestionImage(String path) {
  //if question has no image, return null
  if (path.isEmpty) return null;
  //otherwise try to get the image
  return Image.asset(
    'assets/images/questions/$path',
    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
      //on fail return default error image
      return Image.asset('assets/images/questions/error.png');
    },
  );
}