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
            name: 'Rezystancja',
            value: ref.watch(calcOhmsLawResistanceValue),
            min: 1,
            max: 1000,
            divisions: 999,
            onChanged: (val) => ref.read(calcOhmsLawController).setResistanceValue(val),
            addValue: (val) => ref.read(calcOhmsLawController).addResistance(val),
          ),
          CalcChooseUnitButtons(
              unitBase: '\u03a9',
          choosePrefix: (index) => ref.read(calcOhmsLawController).setResistanceUnit(index),),

          const SizedBox(
            height: 50,
          ),
          CalcSlider(
            name: 'Napięcie',
            value: ref.watch(calcOhmsLawVoltageValue),
            min: 1,
            max: 1000,
            divisions: 999,
            onChanged: (val) => ref.read(calcOhmsLawController).setVoltageValue(val),
            addValue: (val) => ref.read(calcOhmsLawController).addVoltage(val),

          ),
          CalcChooseUnitButtons(
            unitBase: 'V',
            choosePrefix: (index) => ref.read(calcOhmsLawController).setVoltageUnit(index),),

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
    final TextStyle? ohmsLawStyle = Theme.of(context).textTheme.headlineLarge;
    // log('/// OhmsLawCalcRebuilt ///');
    final String current = ref.watch(calcOhmsLawCurrentValue);
    final double resistance = ref.watch(calcOhmsLawResistanceValue);
    final double voltage = ref.watch(calcOhmsLawVoltageValue);

    final String resistanceUnit = ref.watch(calcOhmsLawResistanceUnit);
    final String voltageUnit = ref.watch(calcOhmsLawVoltageUnit);
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 2,
          child: Text(
            '$current A',
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
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${voltage.round()} ${voltageUnit}V', style: ohmsLawStyle),
              Divider(
                color: ohmsLawStyle?.color, //Theme.of(context).textTheme.headlineMedium?.color,
                thickness: 3,
              ),
              Text(
                '${resistance.round()} $resistanceUnit\u03a9',
                style: ohmsLawStyle,
              ),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
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
  /// Call method when user changed slider position
  final Function(double) onChanged;
  /// Call method when +/- buttons were pushed
  final Function(double)? addValue;

  @override
  Widget build(BuildContext context) {
    // log('/// CalcSlider rebuilt ///');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (addValue != null) IconButton(
                // padding: const EdgeInsets.only(left: 10, right: 0),
                //   constraints: const BoxConstraints(),
                  onPressed: () => addValue!(-1), icon: const Icon(Icons.remove)),
              Text(name, style: Theme.of(context).textTheme.headlineSmall),
              if (addValue != null) IconButton(
                // padding: const EdgeInsets.only(left: 0, right: 10),
                // constraints: const BoxConstraints(),
                  onPressed: () => addValue!(1), icon: const Icon(Icons.add)),
            ],
          ),
          Slider(

            value: value,
            min: min,
            max: max,
            divisions: divisions,
            // label: value.round().toString(),
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
  const CalcChooseUnitButtons({Key? key, required this.unitBase, required this.choosePrefix}) : super(key: key);

  final String unitBase;
  final Function(int) choosePrefix;

  @override
  Widget build(BuildContext context) {
    return GroupButton(
      options: unitGroupButtonOptions(context),
        buttons: unitPrefixes.map((prefix) => prefix+unitBase).toList(),
        onSelected: (index, isSelected) => choosePrefix(index)
        );
  }
}

