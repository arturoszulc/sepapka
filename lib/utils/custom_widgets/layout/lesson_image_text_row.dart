import 'package:flutter/material.dart';
import 'package:sepapka/utils/custom_widgets/layout/layout_custom_widgets.dart';

class LessonImageTextRow extends StatelessWidget {
  const LessonImageTextRow({Key? key, required this.image, this.texts = const []}) : super(key: key);

  final Widget image;
  final List<Widget> texts;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget> [
      Expanded(
          flex: 3,
          child: Center(child: image)),
      const SizedBox(width: 10,),
      Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
        for (Widget text in texts) ...[text]
    ]
      )),
    ],);
  }
}
