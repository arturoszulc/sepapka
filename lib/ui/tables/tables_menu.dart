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
                        proOnly: false,
                        label: 'Jednostki i wielkości fizyczne',
                        onPressed: ()  {
                          context.goNamed(MyScreen.table_units.name);
                        },
                      ),
                      MenuButton(
                        proOnly: true,
                        label: 'Kodowanie barw przewodów',
                        onPressed: ()  {
                          context.goNamed(MyScreen.table_wire_colors.name);
                        },
                      ),
                      MenuButton(
                        proOnly: true,
                        label: 'Symbole przewodów',
                        onPressed: () {
                          context.goNamed(MyScreen.table_wire_symbols.name);
                        },
                      ),
                      MenuButton(
                        proOnly: true,
                        label: 'Obciążalność przewodów',
                        onPressed: ()  {
                          context.goNamed(MyScreen.table_wire_ampacity.name);
                        },
                      ),
                      MenuButton(
                        proOnly: true,
                        label: 'Przekroje i średnice przewodów',
                        onPressed: ()  {
                          context.goNamed(MyScreen.table_wire_diameter.name);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: unlockButton(context),
    );
  }
}