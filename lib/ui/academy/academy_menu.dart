import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/controllers/academy_controller.dart';
import 'package:sepapka/models/academy/unit_lesson_model.dart';
import 'package:sepapka/utils/lessons_data/all_lessons.dart';

import '../../utils/consts/my_screens.dart';
import '../../utils/custom_widgets/lesson_card.dart';

class AcademyMenu extends ConsumerWidget {
  const AcademyMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Unit> units = ref.read(unitsList);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akademia'),
        centerTitle: true,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: units.length,
          itemBuilder: (BuildContext context, int index) {
            final unit = units[index];
            return AcademyCard(
              upperText: 'Rozdział ${index+1}',
              middleText: unit.title,
              lowerText: 'Liczba lekcji: ${unit.lessons.length}',
              proOnly: index > 5,
              onTap: () {
                ref.read(academyController).chooseUnit(academyUnits.indexOf(unit));
                context.goNamed(MyScreen.academyUnit.name);
              },
            );
          }),

      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisSize: MainAxisSize.max,
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Expanded(
      //             child: Column(
      //               children: academyUnits.map((unit) =>
      //                   MenuButton(
      //                     // proOnly: cableLessons.indexOf(lesson) > 0 ? true : false,
      //                     label: unit.title,
      //                     onPressed: () {
      //                       ref.read(academyController).chooseUnit(academyUnits.indexOf(unit));
      //                       context.goNamed(MyScreen.academyUnit.name);
      //                     }
      //                   ),
      //               ).toList()
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: unlockButton(context),
    );
  }
}
