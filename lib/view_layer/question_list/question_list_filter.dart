import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

import '../../utils/consts/question.dart';
import '../../viewmodel_layer/manager.dart';
import '../../utils/custom_widgets/groupbutton_options.dart';

class QuestionListFilter extends StatelessWidget {
  const QuestionListFilter({Key? key}) : super(key: key);
  static double textPadding = 10.0;
  @override
  Widget build(BuildContext context) {
    debugPrint('*** QuestionListFilter Screen built ***');
    final manager = Provider.of<Manager>(context);

    return WillPopScope(
        onWillPop: () => context.read<Manager>().getFilteredQuestionList(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.read<Manager>().getFilteredQuestionList(),
            ),
            title: const Text('Filtry'),
            elevation: 0.0,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: textPadding),
                    child: Text('Rodzaj pytań', style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  GroupButton(
                    options: myGroupButtonOptions(),
                    onSelected: (index, isSelected) => manager.setListFilter(fType: index),
                    buttons: qTypeList,
                    controller: GroupButtonController(
                      selectedIndex: manager.filterType,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: textPadding),
                    child: Text('Poziom trudności', style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  GroupButton(
                    options: myGroupButtonOptions(),
                    // isRadio: true,
                    onSelected: (index, isSelected) => manager.setListFilter(fLevel: index),
                    buttons: qLevelList,
                    controller: GroupButtonController(
                      selectedIndex: manager.filterLevel,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: textPadding),
                    child: Text('Kategoria', style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  GroupButton(
                    options: myGroupButtonOptions(),
                    isRadio: true,
                    onSelected: (index, isSelected) => manager.setListFilter(fCategory: index),
                    buttons: qCategoryList,
                    controller: GroupButtonController(
                      selectedIndex: manager.filterCategory,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ));
  }
}
