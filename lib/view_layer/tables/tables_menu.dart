import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../utils/consts/my_screens.dart';
import '../../utils/custom_widgets/buttons/menu_button.dart';
import '../../utils/custom_widgets/buttons/unlock_button.dart';

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
                          label: 'Jednostki i wielkości fizyczne',
                          onPressed: ()  {
                            context.goNamed(MyScreen.tableUnits.name);
                          },
                        ),
                        MenuButton(
                          proOnly: true,
                          label: 'Kodowanie barw przewodów',
                          onPressed: ()  {
                            context.goNamed(MyScreen.tableWireColors.name);
                          },
                        ),
                        MenuButton(
                          proOnly: true,
                          label: 'Symbole przewodów',
                          onPressed: () {
                            context.goNamed(MyScreen.tableWireSymbols.name);
                          },
                        ),
                        MenuButton(
                          proOnly: true,
                          label: 'Obciążalność przewodów',
                          onPressed: ()  {
                            context.goNamed(MyScreen.tableWireAmpacity.name);
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