import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/consts/nav.dart';

import '../../utils/custom_widgets/buttons/menu_button.dart';
import '../../utils/custom_widgets/unlock_button.dart';
import '../../viewmodel_layer/manager.dart';

class CalculatorsMenuScreen extends StatelessWidget {
  const CalculatorsMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** CalculatorsMenu Screen built ***');

    return WillPopScope(
      onWillPop: () {
        return context.read<Manager>().navigate(MyScreen.menu);
      },
      child: Scaffold(
      // backgroundColor: myPrimaryLight,
      appBar: AppBar(
      leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
      context.read<Manager>().navigate(MyScreen.menu);
      },
      ),
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
                context.read<Manager>().navigate(MyScreen.calcHeatingPowerThreePhase);
              }),
      ],),
        ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: unlockButton(context),
      ),
    );
  }
}
