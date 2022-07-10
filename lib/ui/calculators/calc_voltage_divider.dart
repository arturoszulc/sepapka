import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/calcs/calc_voltage_divider_controller.dart';
import 'calc_ohms_law.dart';

class CalcVoltageDivider extends ConsumerWidget {
  const CalcVoltageDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dzielnik napięcia'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: VoltageDividerVisualisation(),
          ),
          CalcSlider(
            name: 'Napięcie',
            value: ref.watch(calcVoltageDividerFractionSwitchV1) ? ref.watch(calcVoltageDividerVoltageFractionalPart) : ref.watch(calcVoltageDividerVoltageWholePart),
            min: 1,
            max: 1000,
            divisions: 999,
            onChanged: (val) => ref.read(calcVoltageDividerController).setVoltageValue(val),
            addValue: (val) => ref.read(calcVoltageDividerController).addVoltage(val),
            switchFraction: (bool val) => ref.read(calcVoltageDividerController).switchVoltageFraction(val),
            isFraction: ref.watch(calcVoltageDividerFractionSwitchV1),

          ),
        ],
      ),
    );
  }
}


class VoltageDividerVisualisation extends ConsumerWidget {
  const VoltageDividerVisualisation({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle? voltageDividerStyle = Theme.of(context).textTheme.bodyLarge;
    final double height = MediaQuery.of(context).size.width*0.5;
    final double paddingVertical = height*0.04;

    final String voltageValue = ref.watch(calcVoltageDividerVoltageValue).toStringAsFixed(2);

    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          //picture
          Container(
            // color: Colors.yellow,
            child: Image.asset(
              'assets/images/calcs/voltage-divider.png',
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                //on fail return default error image
                return Image.asset('assets/images/questions/error.png');
              },
            ),
          ),
           Padding(
             padding: EdgeInsets.symmetric(horizontal: height*0.1, vertical: paddingVertical),
             child: Row(
               children: [
                 //voltage input
                 Expanded(
                     flex: 8,
                     child: Column(
                       // mainAxisAlignment: MainAxisAlignment.center,
                       // crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                     Expanded(child: Align(
                         alignment: Alignment.centerRight,
                         child: Text('1000.00 O', textAlign: TextAlign.right, style: voltageDividerStyle,))),
                     Expanded(child: Align(
                         alignment: Alignment.centerRight,
                         child: Text('1000.15 kO', textAlign: TextAlign.right, style: voltageDividerStyle,))),
                   ],
                 )),
                 Expanded(
                     flex: 9,
                     child: Column(
                       // mainAxisAlignment: MainAxisAlignment.center,
                       // crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         Expanded(child: SizedBox()),
                         Expanded(child: Align(
                             alignment: Alignment.centerRight,
                             child: Text('1000.15 V', textAlign: TextAlign.right, style: voltageDividerStyle,))),
                       ],
                     )),
                 //resistances
                 //voltage output
               ],
             ),
           ),
           Padding(
             padding: EdgeInsets.symmetric(horizontal: height*0.1, vertical: paddingVertical),
             child: Align(
                 alignment: Alignment.centerLeft,
                 child: Text('$voltageValue kV', textAlign: TextAlign.left, style: voltageDividerStyle,)),
           ),

        ],
      ),
    );
  }
}
