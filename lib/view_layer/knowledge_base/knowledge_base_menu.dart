import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/consts/nav.dart';
import '../../utils/custom_widgets/menu_button.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MenuButton(
                              label: 'Kolory przewodów',
                              onPressed: () async {
                                await context.read<Manager>().navigate(Screen.tableWireColors);
                              },
                            ),
                            MenuButton(
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
                ),
              ],
            ),
          )),);
  }
}