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
                child: const Icon(Icons.settings),
              ),

              //wersja poprzednia z username i iconą usera jako przycisk
              // child: Row(
              //   children: [
              //     Text(
              //       context.read<Manager>().loggedUser!.username,
              //       style: const TextStyle(fontSize: 16),
              //     ),
              //     const SizedBox(width: 10),
              //     const Icon(Icons.account_circle),
              //   ],
              // ),

            ],
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          const SizedBox(height: 20.0),
          Text(context.read<Manager>().loggedUser!.username,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),

          Container(
            height: 3,
            width: 20,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20.0),
          const Text('Twoja ranga:'),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(context.read<Manager>().userRankName),
                  const SizedBox(height: 10.0),
                  Text('${context.read<Manager>().loggedUser!.rankTotalPoints} pkt.'),
                ],
              ),
              const SizedBox(width: 20,),
              Column(
                children: [
                  Image.asset(context.read<Manager>().getBadgePath(),
                    height: 60,
                    width: 60,),
                  const SizedBox(height: 10.0),
                  buildProgressBar(context, 80),
                ],
              ),
            ],
          ),
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
                    // hasBadge: true,
                    // badgeNum: howManyToPractice,
                    label: 'Quiz',
                    onPressed: //howManyToPractice == 0
                        // ? null
                        () async {
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

      // bottomNavigationBar: BottomAppBar(
      //     color: Colors.transparent,
      //     elevation: 0,
      //     child: SafeArea(child: buildProgressBar(context))
      // ),
    );
  }
}
