import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/utils/custom_widgets/buttons/menu_button.dart';
import 'package:sepapka/viewmodel_layer/auth_controller.dart';

import '../../viewmodel_layer/app_state_controller.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** Menu Main Screen built ***');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            //to avoid double rebuilds, I should put a Consumer here, but it has low performance impact
            child: Text('v. ${ref.watch(appVersionProvider).value} (beta)'),
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
                      context.goNamed(MyScreen.quizChooseLevel.name);
                    }),
                // MenuButton(
                //     label: 'Lista pytań',
                //     onPressed: () {
                //       context.goNamed(MyScreen.listQuestion.name);
                //     }),
                MenuButton(
                    label: 'Akademia',
                    onPressed: () {
                      context.goNamed(MyScreen.academyMenu.name);
                      // context.read<AcademyManager>().getFileName();
                    }),
                MenuButton(
                    label: 'Tablice',
                    onPressed: () {
                      context.goNamed(MyScreen.tablesMenu.name);
                      // context.pop();
                    }),
                MenuButton(
                    label: 'Kalkulatory',
                    onPressed: () {
                      context.goNamed(MyScreen.calcMenu.name);
                    }),
                MenuButton(label: 'Wyloguj się', onPressed: () async {
                  await ref.read(authController).signOut();
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
