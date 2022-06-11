import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../utils/consts/my_screens.dart';

import '../../utils/custom_widgets/buttons/menu_button.dart';
import '../../utils/custom_widgets/unlock_button.dart';
import '../../viewmodel_layer/manager.dart';
import '../../viewmodel_layer/manager_calc.dart';

class CalculatorsMenuScreen extends StatelessWidget {
  const CalculatorsMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** CalculatorsMenu Screen built ***');


            return Scaffold(
        // backgroundColor: myPrimaryLight,
        appBar: AppBar(
        title: const Text('Kalkulatory'),
        centerTitle: true,
        ),
        body: Center(
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        MenuButton(
        proOnly: true,
        label: 'Moc grzania w obwodach 3-fazowych',
        onPressed: () {
          // context.go(MyScreen.calcHeatingPowerThreePhase.path);
        context.read<Manager>().navigate(MyScreen.calcHeatingPowerThreePhase);
        }),
        ],),
        ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: unlockButton(context),
        );

  }
}
