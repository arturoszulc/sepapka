import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

import '../../viewmodel_layer/manager.dart';

class QuestionListFilter extends StatelessWidget {
  const QuestionListFilter({Key? key}) : super(key: key);
  static double textPadding = 10.0;
  static double groupButtonTextPadding = 10.0;
  static double groupButtonPadding = 10.0;
  @override
  Widget build(BuildContext context) {
    debugPrint('*** QuestionListFilter Screen built ***');
    final manager = Provider.of<Manager>(context);
    List<String> qCategories = manager.qCategories;

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
                    options: GroupButtonOptions(
                      // mainGroupAlignment: MainGroupAlignment.end,
                      // spacing: 20,
                    ),
                    // isRadio: true,
                    onSelected: (index, isSelected) => manager.setListFilter(fType: index),
                    buttons: ["Wszystkie", "Tylko widoczne", "Tylko ukryte",],
                    controller: GroupButtonController(
                      selectedIndex: manager.filterType,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: textPadding),
                    child: Text('Poziom trudności', style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  GroupButton(
                    options: GroupButtonOptions(

                      textPadding: EdgeInsets.symmetric(horizontal: groupButtonTextPadding,),
                      // unselectedTextStyle: TextStyle(),
                      mainGroupAlignment: MainGroupAlignment.spaceEvenly,
                      // spacing: 20,
                    ),
                    // isRadio: true,
                    onSelected: (index, isSelected) => manager.setListFilter(fLevel: index),
                    buttons: ["Wszystkie", "Poziom 1", "Poziom 2", "Poziom 3"],
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
                    options: GroupButtonOptions(
                      // buttonWidth: 150,
                      textPadding: EdgeInsets.symmetric(horizontal: groupButtonTextPadding,),
                      // buttonHeight: 50,
                      groupingType: GroupingType.wrap,
                      // mainGroupAlignment: MainGroupAlignment.start,
                      // crossGroupAlignment: CrossGroupAlignment.start,
                      spacing: groupButtonPadding,
                    ),
                    isRadio: true,
                    onSelected: (index, isSelected) => manager.setListFilter(fCategory: index),
                    buttons: qCategories,
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
