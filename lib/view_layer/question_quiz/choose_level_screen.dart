import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/custom_widgets/buttons/menu_button.dart';
import 'package:sepapka/utils/custom_widgets/unlock_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/nav.dart';

class MenuChooseLevel extends StatelessWidget {
  const MenuChooseLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** ChooseLevel Screen built ***');

    List<int> countLevels = context.read<Manager>().countQuestionsByLevel;
    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(Screen.menu),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.read<Manager>().navigate(Screen.menu),
          ),
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
                            onPressed: () async {
                              await context.read<Manager>().chooseQuestionLevel(0);
                            },
                          ),
                          MenuButton(
                            hasBadge: true,
                            badgeNum: countLevels[1],
                            label: 'poziom 1',
                            onPressed: () async {
                                    await context.read<Manager>().chooseQuestionLevel(1);
                                  },
                          ),
                          MenuButton(
                            hasBadge: true,
                            badgeNum: countLevels[2],
                            label: 'poziom 2',
                            onPressed: () async {
                              await context.read<Manager>().chooseQuestionLevel(2);
                                  },
                          ),
                          MenuButton(
                            hasBadge: true,
                            badgeNum: countLevels[3],
                            label: 'poziom 3',
                            onPressed: () async {
                              await context.read<Manager>().chooseQuestionLevel(3);
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
      ),
    );
  }
}
