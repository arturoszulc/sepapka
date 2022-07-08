import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/utils/consts/question.dart';
import 'package:sepapka/utils/custom_widgets/buttons/menu_button.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/controllers/quiz_controller.dart';

class MenuChooseLevel extends ConsumerWidget {
  const MenuChooseLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** ChooseLevel Screen built ***');

    // List<int> countLevels = ref.read(manager).countQuestionsByLevel;
    List<int> countLevels = ref.watch(numOfQuestionsByLevel);
    return WillPopScope(
      onWillPop: () async {
      context.goNamed(MyScreen.menu.name);
      return false;},
      child: Scaffold(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: qLevelList.map((level) =>
                          MenuButton(
                            hasBadge: true,
                            badgeNum: countLevels[qLevelList.indexOf(level)],
                            label: level,
                            onPressed: () {
                              ref.read(quizController).setLevel(qLevelList.indexOf(level));
                              context.goNamed(MyScreen.quizChooseCategory.name);
                            },
                          ),
                      ).toList()
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
          context.pushNamed(MyScreen.listQuestion.name);
        },
            label: const Text('Lista pytań'),
          icon: const Icon(Icons.list),
        ),
      ),
    );
  }
}
