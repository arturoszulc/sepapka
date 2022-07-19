import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/controllers/academy_controller.dart';

import '../../models/academy/unit_lesson_model.dart';
import '../../utils/consts/my_screens.dart';

class AcademyLesson extends ConsumerWidget {
  AcademyLesson({Key? key}) : super(key: key);


  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: false,
  );
  // final Lesson lesson;
  static const TextStyle bold = TextStyle(
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('/// AcademyLesson built ///');
    final int numOfLessons = ref.watch(chosenUnit).lessons.length;
    final int lessonIndex = ref.watch(chosenLessonIndex);
    final Lesson lesson = ref.watch(chosenLesson);
    final bool isNextLesson = ref.watch(isNextLessonAvailable);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lekcja ${lessonIndex+1}'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            context.pushNamed(MyScreen.academy_index.name);
          }, icon: const Icon(Icons.menu_book)),
        ],
      ),
      body: SingleChildScrollView(
controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(lesson.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall,),
            ...lesson.content,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  if(lessonIndex > 0) ElevatedButton(onPressed: ()  {
                    _scrollController.jumpTo(0.0);
                    ref.read(academyController).chooseLesson(lessonIndex-1);
                  }, child: const Text('Poprzednia lekcja'),),
                  if(isNextLesson)ElevatedButton(onPressed: () {
                    _scrollController.jumpTo(0.0);
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



