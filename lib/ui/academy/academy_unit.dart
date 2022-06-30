import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/controllers/academy_controller.dart';
import '../../utils/consts/my_screens.dart';
import '../../utils/custom_widgets/buttons/menu_button.dart';
import '../../utils/custom_widgets/buttons/unlock_button.dart';

class AcademyUnit extends ConsumerWidget {
  const AcademyUnit({Key? key}) : super(key: key);

  // final Unit unit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = ref.watch(chosenUnit);
    return Scaffold(
      appBar: AppBar(
        title: const Text('placeholder'),
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
                      children: unit.lessons.map((lesson) =>
                          MenuButton(
                            proOnly: unit.lessons.indexOf(lesson) > 0 ? true : false,
                            label: lesson.title,
                            onPressed: () => context.goNamed(MyScreen.academyLesson.name)//, params: {'uid': unit.id, 'id': lesson.id}),
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