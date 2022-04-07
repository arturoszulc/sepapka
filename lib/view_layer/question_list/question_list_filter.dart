import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/nav.dart';

import '../../viewmodel_layer/manager.dart';

class QuestionListFilter extends StatelessWidget {
  const QuestionListFilter({Key? key}) : super(key: key);
  static double textPadding = 10.0;
  static double groupButtonTextPadding = 10.0;
  static double groupButtonPadding = 10.0;
  @override
  Widget build(BuildContext context) {
    debugPrint('*** QuestionListFilter Screen built ***');
    List<String> qCategories = Provider.of<Manager>(context).qCategories;

    return WillPopScope(
        onWillPop: () => context.read<Manager>().navigate(Screen.listQuestion),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.read<Manager>().navigate(Screen.listQuestion),
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
                    onSelected: (index, isSelected) => print('$index button is selected'),
                    buttons: ["Wszystkie", "Tylko widoczne", "Tylko ukryte",],
                    controller: GroupButtonController(
                      selectedIndex: 2,
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
                      unselectedTextStyle: TextStyle(),
                      mainGroupAlignment: MainGroupAlignment.spaceEvenly,
                      // spacing: 20,
                    ),
                    // isRadio: true,
                    onSelected: (index, isSelected) => print('$index button is selected'),
                    buttons: ["Poziom 1", "Poziom 2", "Poziom 3", "wszystkie poziomy"],
                    controller: GroupButtonController(
                      selectedIndex: 2,
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
                    onSelected: (index, isSelected) => print('$index button is selected'),
                    buttons: qCategories,
                    controller: GroupButtonController(
                      selectedIndex: 2,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ));
  }
}
