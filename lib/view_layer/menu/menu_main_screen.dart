import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/utils/custom_widgets/buttons/menu_button.dart';
import 'package:sepapka/viewmodel_layer/auth_controller.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/viewmodel_layer/route_controller.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** Menu Main Screen built ***');
    final myManager = ref.read(manager);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('v. ${myManager.appVersion} (beta)'),
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
                  key: ,
                    label: 'Quiz',
                    onPressed: () {
                      myManager.navigate(MyScreen.quizChooseLevel);
                    }),
                MenuButton(
                    label: 'Lista pytań',
                    onPressed: () {
                      ref.read(routeController).navigate(MyScreen.listQuestion);
                    }),
                MenuButton(
                    label: 'Akademia',
                    onPressed: () {
                      // context.read<AcademyManager>().getFileName();
                    }),
                MenuButton(
                    label: 'Tablice',
                    onPressed: () {
                      // context.go(MyScreen.knowledgeBase.name);
                      // context.pop();
                      ref.read(routeController).navigate(MyScreen.academyMenu);
                    }),
                MenuButton(
                    label: 'Kalkulatory',
                    onPressed: () {
                      myManager.navigate(MyScreen.calcMenu);
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
