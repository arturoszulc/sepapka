import 'package:flutter/material.dart';
import 'package:sepapka/utils/consts/colors.dart';


Widget buildImage(BuildContext context, String path) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  //if question has no image, return null
  if (!path.endsWith('.png')) return Container();
  //otherwise try to get the image
  return ColorFiltered(
    colorFilter: ColorFilter.matrix(isDarkMode ? matrixInverse : matrixIdentity),
    child: Image.asset(
      path,
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        //on fail return default error image
        return Image.asset('assets/images/questions/error.png');
      },
    ),
  );
}