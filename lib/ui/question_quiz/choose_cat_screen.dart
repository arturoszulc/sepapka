import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/utils/consts/question.dart';
import 'package:sepapka/utils/custom_widgets/buttons/menu_button.dart';

import '../../controllers/quiz_controller.dart';

class ChooseCategory extends ConsumerWidget {
  const ChooseCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** ChooseCategory Screen built ***');

    List<int> countCategories = ref.watch(numOfQuestionsByCategory);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wybierz kategorię'),
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
                    children:  qCategoryList.map((category) =>
                    MenuButton(
                        label: category,
                        hasBadge: true,
                        badgeNum: countCategories[qCategoryList.indexOf(category)],
                        onPressed: () {
                          ref.read(quizController).setCategory(qCategoryList.indexOf(category));
                          ref.read(quizController).prepareSession();
                          context.goNamed(MyScreen.quiz_question_single.name);
                        }),
                    ).toList()

                    // [
                    //   MenuButton(
                    //     label: qCategoryList[0],
                    //     hasBadge: true,
                    //     badgeNum: countQuestionsByCategories[0],
                    //     onPressed: () {
                    //       ref.read(quizController.notifier).setCategory(0);
                    //     },
                    //   ),
                    //   MenuButton(
                    //     label: qCategoryList[1],
                    //     hasBadge: true,
                    //     badgeNum: countQuestionsByCategories[1],
                    //     onPressed: () async {
                    //       await ref.read(manager).chooseQuestionCategory(1);
                    //     },
                    //   ),
                    //   MenuButton(
                    //     label: qCategoryList[2],
                    //     hasBadge: true,
                    //     badgeNum: countQuestionsByCategories[2],
                    //     onPressed: () async {
                    //       await ref.read(manager).chooseQuestionCategory(2);
                    //     },
                    //   ),
                    //   MenuButton(
                    //     label: qCategoryList[3],
                    //     hasBadge: true,
                    //     badgeNum: countQuestionsByCategories[3],
                    //     onPressed: () async {
                    //       await ref.read(manager).chooseQuestionCategory(3);
                    //     },
                    //   ),
                    //   MenuButton(
                    //     label: qCategoryList[4],
                    //     hasBadge: true,
                    //     badgeNum: countQuestionsByCategories[4],
                    //     onPressed: () async {
                    //       await ref.read(manager).chooseQuestionCategory(4);
                    //     },
                    //   ),
                    // ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
