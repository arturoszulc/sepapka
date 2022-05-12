import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/custom_widgets/menu_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/nav.dart';

class MenuChooseLevel extends StatelessWidget {
  const MenuChooseLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** ChooseLevel Screen built ***');

    List<int> countLevels = context.read<Manager>().countQuestionsByLevel;
    bool isUserPro = context.read<Manager>().loggedUser!.isPro;
    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(Screen.menu),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                            proOnly: true,
                            isUserPro: isUserPro,
                            label: 'poziom 2',
                            onPressed: () async {
                              await context.read<Manager>().chooseQuestionLevel(2);
                                  },
                          ),
                          MenuButton(
                            hasBadge: true,
                            badgeNum: countLevels[3],
                            proOnly: true,
                            isUserPro: isUserPro,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: isUserPro ? null : FloatingActionButton.extended(onPressed: () {
          context.read<Manager>().revenueCatStart();
        }, label: Row(
          children: const [
            Text('Odblokuj pytania'),
            SizedBox(width: 5),
            Icon(Icons.lock_open, size: 16, color: Colors.black,),
          ],
        ),),
      ),
    );
  }
}
