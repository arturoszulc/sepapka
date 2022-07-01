import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/controllers/academy_controller.dart';
import 'package:sepapka/utils/custom_widgets/lesson_card.dart';
import '../../utils/consts/my_screens.dart';
import '../../utils/custom_widgets/buttons/unlock_button.dart';

class AcademyUnit extends ConsumerWidget {
  const AcademyUnit({Key? key}) : super(key: key);

  // final Unit unit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = ref.watch(chosenUnit);
    return Scaffold(
      appBar: AppBar(
        title: Text(unit.title),
        centerTitle: true,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: unit.lessons.length,
          itemBuilder: (BuildContext context, int index) => LessonCard(
            lesson: unit.lessons[index],
            proOnly: index > 5,
            onTap: () {
              ref.read(academyController).chooseLesson(index);
              context.goNamed(MyScreen.academyLesson.name);
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: unlockButton(context),
    );
  }
}