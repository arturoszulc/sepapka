import 'package:flutter/material.dart';

import '../../consts/colors.dart';

class ImageCaption extends StatelessWidget {
  const ImageCaption({Key? key, required this.path, this.caption = '', this.ignoreDarkMode = false}) : super(key: key);

  final String path;
  final String caption;
  final bool ignoreDarkMode;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ignoreDarkMode ? false : Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Column(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.matrix(isDarkMode ? matrixInverse : matrixIdentity),
            child: Image.asset(
              path,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                //on fail return default error image
                return Image.asset('assets/images/questions/error.png');
              },
            ),
          ),
          if (caption.isNotEmpty) const SizedBox(height: 10,),
          Text(caption, style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),),
        ],
      ),
    );
  }
}
