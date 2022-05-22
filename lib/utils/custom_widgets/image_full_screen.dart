import 'package:flutter/material.dart';
import 'package:sepapka/utils/custom_widgets/build_question_image.dart';

class ImageFullScreen extends StatelessWidget {
  final String imagePath;
  final double minScale = 1;
  final double maxScale = 3;

  const ImageFullScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.maybePop(context);
      },
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.grey[50],
          //   leading: IconButton(
          //     icon: const Icon(Icons.clear, color: Colors.black),
          //     onPressed: () => Navigator.pop(context),
          //   ),
          // ),
          body: Center(
            child: Hero(
              tag: 'imageHero',
              child: InteractiveViewer(
                  clipBehavior: Clip.none,
                  minScale: minScale,
                  maxScale: maxScale,
                  child: buildQuestionImage(context, imagePath)),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.clear),
              onPressed: () {Navigator.pop(context);}),
        ),
      ),
    );
  }
}
