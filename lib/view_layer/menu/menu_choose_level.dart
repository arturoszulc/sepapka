import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/view_layer/custom_widgets/menu_button.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:badges/badges.dart';

class MenuChooseLevel extends StatelessWidget {
  const MenuChooseLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** MenuChooseLevel built ***');

    int countLevel1 = context.read<Manager>().qNewLeftLevel1;
    int countLevel2 = context.read<Manager>().qNewLeftLevel2;
    int countLevel3 = context.read<Manager>().qNewLeftLevel3;
    bool isUserPro = context.read<Manager>().loggedUser!.isPro;
    return Scaffold(
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
                          hasBadge: true,
                          badgeNum: countLevel1,
                          label: 'Poziom 1',
                          onPressed: countLevel1 < 1
                              ? null
                              : () async {
                                  await context.read<Manager>().startNew(qLevel: 1);
                                },
                        ),
                        MenuButton(
                          hasBadge: true,
                          badgeNum: countLevel2,
                          label: 'Poziom 2',
                          onPressed: !isUserPro || countLevel2 < 1
                              ? null
                              : () async {
                                  await context.read<Manager>().startNew(qLevel: 2);
                                },
                        ),
                        MenuButton(
                          hasBadge: true,
                          badgeNum: countLevel3,
                          label: 'Poziom 3',
                          onPressed: !isUserPro || countLevel3 < 1
                              ? null
                              : () async {
                                  await context.read<Manager>().startNew(qLevel: 3);
                                },
                        ),
                        // Badge(
                        //   badgeContent: Text(
                        //     countLevel1.toString(),
                        //     style: const TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        //   toAnimate: false,
                        //   badgeColor: Colors.blue,
                        //   showBadge: countLevel1 == 0 ? false : true,
                        //   child: ElevatedButton(
                        //     onPressed: countLevel1 < 1
                        //         ? null
                        //         : () async {
                        //             await context
                        //                 .read<Manager>()
                        //                 .startNew(qLevel: 1);
                        //           },
                        //     child: Text('Poziom 1'),
                        //   ),
                        // ),
                        // Badge(
                        //   badgeContent: Text(
                        //     countLevel2.toString(),
                        //     style: const TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        //   toAnimate: false,
                        //   badgeColor: Colors.blue,
                        //   showBadge: countLevel2 == 0 ? false : true,
                        //   child: ElevatedButton(
                        //     onPressed: !isUserPro || countLevel2 < 1
                        //         ? null
                        //         : () async {
                        //             await context
                        //                 .read<Manager>()
                        //                 .startNew(qLevel: 2);
                        //           },
                        //     child: Text('Poziom 2'),
                        //   ),
                        // ),
                        // Badge(
                        //   badgeContent: Text(
                        //     countLevel3.toString(),
                        //     style: const TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        //   toAnimate: false,
                        //   badgeColor: Colors.blue,
                        //   showBadge: countLevel3 == 0 ? false : true,
                        //   child: ElevatedButton(
                        //     onPressed: !isUserPro || countLevel3 < 1
                        //         ? null
                        //         : () async {
                        //             await context
                        //                 .read<Manager>()
                        //                 .startNew(qLevel: 3);
                        //           },
                        //     child: Text('Poziom 3'),
                        //   ),
                        // ),
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
    );
  }
}
