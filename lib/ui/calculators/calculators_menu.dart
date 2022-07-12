import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../utils/consts/my_screens.dart';
import '../../utils/custom_widgets/buttons/menu_button.dart';
import '../../utils/custom_widgets/buttons/unlock_button.dart';

class CalculatorsMenuScreen extends ConsumerWidget {
  const CalculatorsMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('*** CalculatorsMenu Screen built ***');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulatory'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MenuButton(
                label: 'Prawo Ohma',
                onPressed: () {
                  context.goNamed(MyScreen.calc_ohms_law.name);
                }),
            MenuButton(
                label: 'Dzielnik napięcia',
                onPressed: () {
                  context.goNamed(MyScreen.calc_voltage_divider.name);
                }),
            MenuButton(
                proOnly: true,
                label: 'Moc grzania w obwodach 3-fazowych',
                onPressed: () {
                  context.goNamed(MyScreen.calc_heating_power_three_phase.name);
                }),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: unlockButton(context),
    );
  }
}
