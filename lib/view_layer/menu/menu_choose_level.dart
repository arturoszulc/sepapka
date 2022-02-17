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
                            onPressed: () async {
                                    await context.read<Manager>().startNew(qLevel: 1);
                                  },
                          ),
                          MenuButton(
                            hasBadge: true,
                            badgeNum: countLevel2,
                            proOnly: true,
                            isUserPro: isUserPro,
                            label: 'Poziom 2',
                            onPressed: () async {
                                    await context.read<Manager>().startNew(qLevel: 2);
                                  },
                          ),
                          MenuButton(
                            hasBadge: true,
                            badgeNum: countLevel3,
                            proOnly: true,
                            isUserPro: isUserPro,
                            label: 'Poziom 3',
                            onPressed: () async {
                                    await context.read<Manager>().startNew(qLevel: 3);
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
