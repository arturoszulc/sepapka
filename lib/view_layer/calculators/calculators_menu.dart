import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager_calc.dart';
import '../../utils/consts/nav.dart';

import '../../utils/custom_widgets/menu_button.dart';
import '../../viewmodel_layer/manager.dart';

class CalculatorsMenuScreen extends StatelessWidget {
  const CalculatorsMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** CalculatorsMenu Screen built ***');

    return Scaffold(
    // backgroundColor: myPrimaryLight,
    appBar: AppBar(
    leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () {
    context.read<Manager>().navigate(Screen.menu);
    },
    ),
      title: Text('Kalkulatory'),
      centerTitle: true,
    ),
    body: Center(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MenuButton(
            label: 'Moc w obwodach 3-fazowych',
            onPressed: () {
              context.read<Manager>().navigate(Screen.calcPowerThreePhase);
            }),
    ],),
      ),
    ));
  }
}
