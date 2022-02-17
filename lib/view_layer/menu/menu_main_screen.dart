import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/view_layer/custom_widgets/menu_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import '../custom_widgets/progress_bar_global.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Menu built ***');

    int howManyToPractice = context.read<Manager>().howManyToPracticeToday;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.read<Manager>().navigate(Screen.settings);
                },
                child: Row(
                  children: [
                    Text(
                      context.read<Manager>().loggedUser!.username,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.account_circle),
                  ],
                ),
              ),
              // Text(
              //   context.read<Manager>().loggedUser!.username,
              //   style: const TextStyle(fontSize: 16),
              // ),
              // IconButton(
              //     onPressed: () {
              //       context.read<Manager>().navigate(Screen.settings);
              //     },
              //     icon: const Icon(Icons.account_circle)),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MenuButton(
                      label: 'Nauka',
                      onPressed: () {
                        context.read<Manager>().navigate(Screen.chooseLevel);
                      }),
                  MenuButton(
                      hasBadge: true,
                      badgeNum: howManyToPractice,
                      label: 'Powtórka materiału',
                      onPressed: howManyToPractice == 0
                          ? null
                          : () async {
                              await context.read<Manager>().startPractice();
                            }),
                  MenuButton(
                      label: 'Lista pytań',
                      onPressed: () {
                        context.read<Manager>().getFilteredQuestionList();
                      }),
                  MenuButton(
                      proOnly: true,
                      isUserPro: context.read<Manager>().loggedUser!.isPro,
                      label: 'Ranking',
                      onPressed: () {
                        context.read<Manager>().navigate(Screen.userRank);
                      })
                ],
              ),
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: SafeArea(child: buildProgressBar(context))),
    );
  }
}
