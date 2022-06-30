import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/utils/custom_widgets/layout/bullet_list.dart';
import 'package:sepapka/utils/custom_widgets/layout/header.dart';
import 'package:sepapka/utils/custom_widgets/layout/image_caption.dart';
import 'package:sepapka/utils/custom_widgets/layout/paragraph.dart';
import 'package:sepapka/utils/lessons_data/lessons_cables.dart';

import '../../models/academy/lesson_model.dart';
import '../../utils/consts/my_screens.dart';

class AcademyLesson extends StatelessWidget {
  const AcademyLesson({Key? key, required this.lesson}) : super(key: key);

  final Lesson lesson;
  static const TextStyle bold = TextStyle(
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lekcja ${lesson.id}'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            context.pushNamed(MyScreen.academyIndex.name);
          }, icon: const Icon(Icons.menu_book)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(lesson.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall,),
            ...lesson.content
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        context.goNamed(MyScreen.academyLesson.name, params: {'id': '2'});
      }, child: const Text('Next lesson'),),
    );
  }
}



