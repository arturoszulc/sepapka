import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_button/group_button.dart';
import 'package:sepapka/viewmodel_layer/question_list_controller.dart';

import '../../utils/consts/question.dart';
import '../../viewmodel_layer/manager.dart';
import '../../utils/custom_widgets/buttons/groupbutton_options.dart';

class QuestionListFilter extends ConsumerWidget {
  const QuestionListFilter({Key? key}) : super(key: key);
  static double textPadding = 10.0;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** QuestionListFilter Screen built ***');
    // final myManager = ref.read(manager);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtry'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(vertical: textPadding),
              child: Text('Typ pytań', style: Theme.of(context).textTheme.headline6,
              ),
            ),
            GroupButton(
              options: myGroupButtonOptions(context),
              onSelected: (index, isSelected)
              {
                ref.read(questionListFilterType.notifier).state = index;},
              buttons: qTypeList,
              controller: GroupButtonController(
                selectedIndex: ref.read(questionListFilterType),
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: textPadding),
              child: Text('Poziom trudności', style: Theme.of(context).textTheme.headline6,
              ),
            ),
            GroupButton(
              options: myGroupButtonOptions(context),
              // isRadio: true,
              onSelected: (index, isSelected) => ref.read(questionListFilterLevel.notifier).state = index,
              buttons: qLevelList,
              controller: GroupButtonController(
                selectedIndex: ref.read(questionListFilterLevel),
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: textPadding),
              child: Text('Kategoria', style: Theme.of(context).textTheme.headline6,
              ),
            ),
            GroupButton(
              options: myGroupButtonOptions(context),
              isRadio: true,
              onSelected: (index, isSelected) => ref.read(questionListFilterCategory.notifier).state = index,
              buttons: qCategoryList,
              controller: GroupButtonController(
                selectedIndex: ref.read(questionListFilterCategory),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
