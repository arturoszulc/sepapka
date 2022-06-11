import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/utils/custom_widgets/buttons/menu_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/viewmodel_layer/manager_academy.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Menu Main Screen built ***');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('v. ${context.read<Manager>().appVersion} (beta)'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          const SizedBox(height: 20.0),
          // buildImage(context, 'assets/images/general/sepapka-logo.png'),
          Image.asset('assets/images/general/sepapka-logo.png', height: 100,),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            height: 3,
            width: 20,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              children: [
                MenuButton(
                    label: 'Quiz',
                    onPressed: () {
                      context.read<Manager>().navigate(MyScreen.chooseLevel);
                    }),
                MenuButton(
                    label: 'Lista pytań',
                    onPressed: () {
                      context.read<Manager>().getFilteredQuestionList();
                    }),
                MenuButton(
                    label: 'Akademia',
                    onPressed: () {
                      context.read<AcademyManager>().getFileName();
                    }),
                MenuButton(
                    label: 'Tablice',
                    onPressed: () {
                      context.read<Manager>().navigate(MyScreen.knowledgeBase);
                    }),
                MenuButton(
                    label: 'Kalkulatory',
                    onPressed: () {
                      context.read<Manager>().navigate(MyScreen.calcMenu);
                    }),
                MenuButton(label: 'Wyloguj się', onPressed: () async {
                  await context.read<Manager>().signOut();
                  // await context.read<Manager>().navigate(Screen.purchase);
                }),
              ],
            ),
          ),
          // const SizedBox(height: 20),

        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.grey,
      //     foregroundColor: Colors.white,
      //     child: const Text('Debug'),
      //     onPressed: () {
      //       context.read<Manager>().navigate(Screen.debug);
      //       // context.read<Manager>().navigate(Screen.purchaseError);
      //     }),
    );
  }
}
