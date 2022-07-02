import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/controllers/academy_controller.dart';

import '../../models/academy/unit_lesson_model.dart';
import '../../utils/consts/my_screens.dart';

class AcademyLesson extends ConsumerWidget {
  const AcademyLesson({Key? key}) : super(key: key);

  // final Lesson lesson;
  static const TextStyle bold = TextStyle(
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int lessonIndex = ref.watch(chosenLessonIndex);
    final Lesson lesson = ref.watch(chosenLesson);
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(lesson.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall,),
            ...lesson.content,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  if(lessonIndex > 0) ElevatedButton(onPressed: () {
                    ref.read(academyController).chooseLesson(lessonIndex-1);
                  }, child: const Text('Poprzednia lekcja'),),
                  ElevatedButton(onPressed: () {
                    ref.read(academyController).chooseLesson(lessonIndex+1);
                  }, child: const Text('Następna lekcja'),),
                ],),
            ),
          ],
        )
      ),
    );
  }
}



