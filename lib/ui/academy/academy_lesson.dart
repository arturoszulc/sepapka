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
    final Lesson lesson = ref.watch(chosenLesson);
    return Scaffold(
      appBar: AppBar(
        title: const Text('placeholder'),
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



