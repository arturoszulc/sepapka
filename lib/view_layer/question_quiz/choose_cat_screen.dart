import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/view_layer/custom_widgets/menu_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';


class ChooseCategory extends StatelessWidget {
  const ChooseCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** ChooseCategory Screen built ***');

    List<String> qCategories = context.read<Manager>().qCategories;
    List<int> countQuestionsByCategories = context.read<Manager>().countQuestionsByCategories;
    return WillPopScope(
        onWillPop: () => context.read<Manager>().navigate(Screen.chooseLevel),
        child: Scaffold(
        appBar: AppBar(
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => context.read<Manager>().navigate(Screen.chooseLevel),
    ),
    title: const Text('Wybierz kategorię'),
    centerTitle: true,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 100),
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
                        label: qCategories[0],
                        hasBadge: true,
                        badgeNum: countQuestionsByCategories[0],
                        onPressed: () async {
                          await context.read<Manager>().chooseQuestionCategory(0);
                        },
                      ),
                      MenuButton(
                        label: qCategories[1],
                        hasBadge: true,
                        badgeNum: countQuestionsByCategories[1],
                        onPressed: () async {
                          await context.read<Manager>().chooseQuestionCategory(1);
                        },
                      ),
                      MenuButton(
                        label: qCategories[2],
                        hasBadge: true,
                        badgeNum: countQuestionsByCategories[2],
                        onPressed: () async {
                          await context.read<Manager>().chooseQuestionCategory(2);
                        },
                      ),
                      MenuButton(
                        label: qCategories[3],
                        hasBadge: true,
                        badgeNum: countQuestionsByCategories[3],
                        onPressed: () async {
                          await context.read<Manager>().chooseQuestionCategory(3);
                        },
                      ),
                      MenuButton(
                        label: qCategories[4],
                        hasBadge: true,
                        badgeNum: countQuestionsByCategories[4],
                        onPressed: () async {
                          await context.read<Manager>().chooseQuestionCategory(4);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
    ),
    );
  }
}