import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_button/group_button.dart';
import 'package:sepapka/controllers/calcs/calc_ohms_law_controller.dart';

import '../../utils/custom_widgets/buttons/groupbutton_options.dart';

class CalcOhmsLaw extends ConsumerWidget {
  const CalcOhmsLaw({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prawo Ohma'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: OhmsLawVisualisation(),
          ),
          CalcSlider(
            name: 'Napięcie',
            value: ref.watch(calcOhmsLawVoltageFractionSwitch) ? ref.watch(calcOhmsLawVoltageFractionalPart) : ref.watch(calcOhmsLawVoltageWholePart),
            min: 1,
            max: 1000,
            divisions: 999,
            onChanged: (val) => ref.read(calcOhmsLawController).setVoltageValue(val),
            addValue: (val) => ref.read(calcOhmsLawController).addVoltage(val),
            switchFraction: (bool val) => ref.read(calcOhmsLawController).switchVoltageFraction(val),
            isFraction: ref.watch(calcOhmsLawVoltageFractionSwitch),

          ),
          CalcChooseUnitButtons(
            unitBase: 'V',
            choosePrefix: (index) => ref.read(calcOhmsLawController).setVoltageUnitIndex(index),
            selectedIndex: ref.watch(calcOhmsLawVoltageUnitIndex),
          ),


          const SizedBox(
            height: 50,
          ),

          CalcSlider(
            name: 'Rezystancja',
            value: ref.watch(calcOhmsLawResistanceFractionSwitch) ? ref.watch(calcOhmsLawResistanceFractionalPart) : ref.watch(calcOhmsLawResistanceWholePart),
            min: 1,
            max: 1000,
            divisions: 999,
            onChanged: (double val) => ref.read(calcOhmsLawController).setResistanceValue(val),
            addValue: (double val) => ref.read(calcOhmsLawController).addResistance(val),
            switchFraction: (bool val) => ref.read(calcOhmsLawController).switchResistanceFraction(val),
            isFraction: ref.watch(calcOhmsLawResistanceFractionSwitch),
          ),
          CalcChooseUnitButtons(
            unitBase: '\u03a9',
            choosePrefix: (index) => ref.read(calcOhmsLawController).setResistanceUnitIndex(index),
            selectedIndex: ref.watch(calcOhmsLawResistanceUnitIndex),
          ),

        ],
      ),
    );
  }
}

class OhmsLawVisualisation extends ConsumerWidget {
  const OhmsLawVisualisation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle? ohmsLawStyle = Theme.of(context).textTheme.headlineMedium;
    // log('/// OhmsLawCalcRebuilt ///');
    final String currentValue = ref.watch(calcOhmsLawCurrentValue);
    final String resistanceValue = ref.watch(calcOhmsLawResistanceValue).toStringAsFixed(2);
    final String voltageValue = ref.watch(calcOhmsLawVoltageValue).toStringAsFixed(2);

    final int currentUnitIndex = ref.watch(calcOhmsLawCurrentUnitIndex);
    final int voltageUnitIndex = ref.watch(calcOhmsLawVoltageUnitIndex);
    final int resistanceIndex = ref.watch(calcOhmsLawResistanceUnitIndex);

    final String currentUnit = calculatedUnitPrefixes[currentUnitIndex];
    final String voltageUnit = selectableUnitPrefixes[voltageUnitIndex];
    final String resistanceUnit = selectableUnitPrefixes[resistanceIndex];
    return Row(
      children: [
        // const Expanded(child: SizedBox()),
        Expanded(
          // flex: 3,
          child: Text(
            '$currentValue ${currentUnit}A',
            style: ohmsLawStyle,
            textAlign: TextAlign.right,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            '=',
            style: ohmsLawStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          // flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$voltageValue ${voltageUnit}V', style: ohmsLawStyle),
                SizedBox(
                  width: 140,
                  child: Divider(
                    color: ohmsLawStyle?.color, //Theme.of(context).textTheme.headlineMedium?.color,
                    thickness: 3,
                  ),
                ),
                Text(
                  '$resistanceValue $resistanceUnit\u03a9',
                  style: ohmsLawStyle,
                ),
              ],
            ),
          ),
        ),
        // const Expanded(
        //     flex: 1,
        //     child: SizedBox()),
      ],
    );
  }
}

class CalcSlider extends StatelessWidget {
  const CalcSlider(
      {Key? key,
        required this.name,
        required this.value,
        required this.min,
        required this.max,
        this.divisions,
        this.isFraction = false,
        required this.switchFraction,
        required this.onChanged,
        this.addValue,
      })
      : super(key: key);
  /// String that is shown above Slider
  final String name;
  /// Slider current value
  final double value;
  final double min;
  final double max;
  final int? divisions;
  /// Switching to decimal Slider
  final bool isFraction;
  final Function(bool) switchFraction;
  /// Call method when user changed slider position
  final Function(double) onChanged;
  /// Call method when +/- buttons were pushed
  final Function(double)? addValue;

  @override
  Widget build(BuildContext context) {
    // log('/// CalcSlider rebuilt ///');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (addValue != null) IconButton(
                    onPressed: () => addValue!(-1), icon: const Icon(Icons.remove)),
                Text(name, style: Theme.of(context).textTheme.headlineSmall),
                if (addValue != null) IconButton(
                    onPressed: () => addValue!(1), icon: const Icon(Icons.add)),
              ],
            ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextButton(
                    onPressed: () => switchFraction(!isFraction),
                    child: isFraction ? const Text('0.00<') : const Text('>0.00')),
              ),//const Icon(Icons.access_alarm),),
            ]
          ),
          isFraction ?
          Slider(
            activeColor: Theme.of(context).colorScheme.onPrimaryContainer,
            value: value,
            min: 0,
            max: 99,
            divisions: 99,
            onChanged: (val) => onChanged(val),
          ) :
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: (val) => onChanged(val),
          ),
        ]);
  }
}


// class CalcSlider extends StatelessWidget {
//   const CalcSlider(
//       {Key? key,
//       required this.name,
//       required this.value,
//       required this.min,
//       required this.max,
//       this.divisions,
//       required this.onChanged,
//       this.addValue,
//       })
//       : super(key: key);
//   /// String that is shown above Slider
//   final String name;
//   /// Slider current value
//   final double value;
//   final double min;
//   final double max;
//   final int? divisions;
//   /// Call method when user changed slider position
//   final Function(double) onChanged;
//   /// Call method when +/- buttons were pushed
//   final Function(double)? addValue;
//
//   @override
//   Widget build(BuildContext context) {
//     // log('/// CalcSlider rebuilt ///');
//     return Column(
//         children: [
//       Text(name, style: Theme.of(context).textTheme.headlineSmall),
//       Row(
//         children: [
//           if (addValue != null) IconButton(
//             // padding: const EdgeInsets.only(left: 10, right: 0),
//             //   constraints: const BoxConstraints(),
//               onPressed: () => addValue!(-1), icon: const Icon(Icons.remove)),
//           Expanded(
//             child: Slider(
//
//                 value: value,
//                 min: min,
//                 max: max,
//                 divisions: divisions,
//                 // label: value.round().toString(),
//                 onChanged: (val) => onChanged(val),
//             ),
//           ),
//           if (addValue != null) IconButton(
//               // padding: const EdgeInsets.only(left: 0, right: 10),
//               // constraints: const BoxConstraints(),
//               onPressed: () => addValue!(1), icon: const Icon(Icons.add)),
//         ],
//       ),
//     ]);
//   }
// }

// class CalcChooseUnitPrefix extends StatelessWidget {
//   const CalcChooseUnitPrefix({Key? key, required this.unitBase, required this.choosePrefix}) : super(key: key);
//
//   final String unitBase;
//   final Function(String) choosePrefix;
//
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(unitBase, style: Theme.of(context).textTheme.headlineSmall,),
//           const Icon(Icons.arrow_drop_down),
//         ],
//       ),
//       itemBuilder: (context) =>
//       unitPrefixes.map((prefix) =>
//           PopupMenuItem(
//             child: Text('$prefix$unitBase'),
//           ),
//       ).toList()
//       // [
//       //   PopupMenuItem(
//       //     child: Text('\u00b5$unitBase'),
//       //   ),
//       //   PopupMenuItem(
//       //     child: Text('m$unitBase'),
//       //   ),
//       //   PopupMenuItem(
//       //     child: Text('k$unitBase'),
//       //   ),
//       //   PopupMenuItem(
//       //     child: Text('M$unitBase'),
//       //   ),
//       // ],
//     );
//   }
// }

class CalcChooseUnitButtons extends StatelessWidget {
  const CalcChooseUnitButtons({Key? key, required this.unitBase, required this.choosePrefix, required this.selectedIndex}) : super(key: key);

  final String unitBase;
  final Function(int) choosePrefix;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return GroupButton(
      options: unitGroupButtonOptions(context),
        buttons: selectableUnitPrefixes.map((prefix) => prefix+unitBase).toList(),
        onSelected: (index, isSelected) => choosePrefix(index),
      controller: GroupButtonController(
        selectedIndex: selectedIndex,
      ),
        );
  }
}

