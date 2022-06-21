import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/utils/custom_widgets/buttons/menu_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/viewmodel_layer/quiz_controller.dart';

class MenuChooseLevel extends ConsumerWidget {
  const MenuChooseLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** ChooseLevel Screen built ***');

    // List<int> countLevels = ref.read(manager).countQuestionsByLevel;
    List<int> countLevels = ref.watch(quizController.notifier).numOfQuestionsByLevel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wybierz poziom trudności'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MenuButton(
                          hasBadge: true,
                          badgeNum: countLevels[0],
                          label: 'wszystkie',
                          onPressed: () {
                            // await ref.read(manager).chooseQuestionLevel(0);
                            ref.read(quizController.notifier).setLevel(0);
                          },
                        ),
                        MenuButton(
                          hasBadge: true,
                          badgeNum: countLevels[1],
                          label: 'poziom 1',
                          onPressed: () {
                                  ref.read(quizController.notifier).setLevel(1);
                                },
                        ),
                        MenuButton(
                          hasBadge: true,
                          badgeNum: countLevels[2],
                          label: 'poziom 2',
                          onPressed: () {
                            // await ref.read(manager).chooseQuestionLevel(2);
                            ref.read(quizController.notifier).setLevel(2);
                          },
                        ),
                        MenuButton(
                          hasBadge: true,
                          badgeNum: countLevels[3],
                          label: 'poziom 3',
                          onPressed: () {
                            // await ref.read(manager).chooseQuestionLevel(3);
                            ref.read(quizController.notifier).setLevel(3);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
