import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/utils/lessons_data/all_lessons.dart';

import '../../utils/consts/my_screens.dart';
import '../../utils/custom_widgets/buttons/menu_button.dart';
import '../../utils/custom_widgets/buttons/unlock_button.dart';

class AcademyMenu extends ConsumerWidget {
  const AcademyMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Akademia'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: cableLessons.map((lesson) =>
                          MenuButton(
                            proOnly: cableLessons.indexOf(lesson) > 0 ? true : false,
                            label: lesson.title,
                            onPressed: () => context.goNamed(MyScreen.academyLesson.name, params: {'id': lesson.id}),
                          ),
                      ).toList()


                      // [
                      //   MenuButton(
                      //       label: 'Lekcja',
                      //       onPressed: () {
                      //         context.goNamed(MyScreen.academyLesson.name, params: {'id': '1-1'});
                      //       }),
                      // ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: unlockButton(context),
    );
  }
}