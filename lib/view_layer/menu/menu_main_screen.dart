import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/view_layer/custom_widgets/menu_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Menu Main Screen built ***');

    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //     },
        //     child: const Icon(Icons.help_outline),
        //   ),
        // ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          const SizedBox(height: 20.0),
          Image.asset('assets/images/general/sepapka-logo.png', height: 100,),
          const SizedBox(height: 20.0),

          Container(
            height: 3,
            width: 20,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20.0),
          // const Text('Twoja ranga:'),
          // const SizedBox(height: 20,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Column(
          //       children: [
          //         Text(context.read<Manager>().userRankName),
          //         const SizedBox(height: 10.0),
          //         Text('${context.read<Manager>().loggedUser!.rankTotalPoints} pkt.'),
          //       ],
          //     ),
          //     const SizedBox(width: 20,),
          //     Column(
          //       children: [
          //         Image.asset(context.read<Manager>().getBadgePath(),
          //           height: 60,
          //           width: 60,),
          //         const SizedBox(height: 10.0),
          //         buildProgressBar(context, 80),
          //       ],
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // MenuButton(
                //     label: 'Nauka',
                //     onPressed: () {
                //       context.read<Manager>().chooseSessionType(QuestionType.learning);
                //
                //     }),
                MenuButton(
                    // hasBadge: true,
                    // badgeNum: howManyToPractice,
                    label: 'Quiz',
                    onPressed: () {
                      context.read<Manager>().navigate(Screen.chooseLevel);
                    }),
                MenuButton(
                    label: 'Lista pytań',
                    onPressed: () {
                      context.read<Manager>().getFilteredQuestionList();
                    }),
                MenuButton(label: 'Wyloguj się', onPressed: () async {
                  await context.read<Manager>().signOut();
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
          foregroundColor: Colors.white,
          child: const Text('Debug'),
          onPressed: () {
            context.read<Manager>().navigate(Screen.debug);
          }),
    );
  }
}
