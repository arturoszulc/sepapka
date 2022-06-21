import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/consts/my_screens.dart';
import '../../utils/custom_widgets/buttons/menu_button.dart';
import '../../utils/custom_widgets/unlock_button.dart';
import '../../viewmodel_layer/manager.dart';

class TablesMenu extends ConsumerWidget {
  const TablesMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
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
                      children: [
                        MenuButton(
                          proOnly: true,
                          label: 'Kodowanie barw przewodów',
                          onPressed: ()  {
                            ref.read(manager).navigate(MyScreen.tableWireColors);
                          },
                        ),
                        MenuButton(
                          proOnly: true,
                          label: 'Symbole przewodów',
                          onPressed: () {
                            ref.read(manager).navigate(MyScreen.tableWireSymbols);
                          },
                        ),
                        MenuButton(
                          proOnly: true,
                          label: 'Obciążalność przewodów',
                          onPressed: ()  {
                            ref.read(manager).navigate(MyScreen.tableWireAmpacity);
                          },
                        ),
                        MenuButton(
                          proOnly: true,
                          label: 'Jednostki i wielkości',
                          onPressed: ()  {
                            ref.read(manager).navigate(MyScreen.units);
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
    );
  }
}