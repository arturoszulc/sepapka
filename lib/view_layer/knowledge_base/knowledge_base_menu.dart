import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/consts/nav.dart';
import '../../utils/custom_widgets/menu_button.dart';
import '../../utils/custom_widgets/unlock_button.dart';
import '../../viewmodel_layer/manager.dart';

class KnowledgeBaseMenu extends StatelessWidget {
  const KnowledgeBaseMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => context.read<Manager>().navigate(Screen.menu),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.read<Manager>().navigate(Screen.menu),
            ),
            title: const Text('Tablice'),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MenuButton(
                              proOnly: true,
                              label: 'Kodowanie barw przewodów',
                              onPressed: () async {
                                await context.read<Manager>().navigate(Screen.tableWireColors);
                              },
                            ),
                            MenuButton(
                              proOnly: true,
                              label: 'Symbole przewodów',
                              onPressed: () async {
                                await context.read<Manager>().navigate(Screen.tableWireSymbols);
                              },
                            ),
                            MenuButton(
                                proOnly: true,
                              label: 'Obciążalność przewodów',
                              onPressed: () async {
                                await context.read<Manager>().navigate(Screen.tableWireAmpacity);
                              },
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: unlockButton(context),
      ),
    );
  }
}