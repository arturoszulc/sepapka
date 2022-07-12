
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_button/group_button.dart';
import 'package:sepapka/controllers/calcs/calc_ohms_law_controller.dart';

import '../../utils/consts/numbers.dart';
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
            value: ref.watch(calcOhmsLawVoltageFractionSwitch) ? ref.watch(calcOhmsLawFractionalPartV1) : ref.watch(calcOhmsLawWholePartV1),
            min: 1,
            max: 999,
            divisions: 998,
            onChanged: (val) => ref.read(calcOhmsLawController).setValueV1(val),
            addValue: (val) => ref.read(calcOhmsLawController).addV1(val),
            switchFraction: (bool val) => ref.read(calcOhmsLawController).switchVoltageFraction(val),
            isFraction: ref.watch(calcOhmsLawVoltageFractionSwitch),

          ),
          CalcChooseUnitButtons(
            unitBase: 'V',
            choosePrefix: (index) => ref.read(calcOhmsLawController).setPrefixV1(index),
            selectedIndex: ref.watch(calcOhmsLawController).unitIndexV1,
          ),


          const SizedBox(
            height: 50,
          ),

          CalcSlider(
            name: 'Rezystancja',
            value: ref.watch(calcOhmsLawResistanceFractionSwitch) ? ref.watch(calcOhmsLawFractionalPartR1) : ref.watch(calcOhmsLawWholePartR1),
            min: 1,
            max: 999,
            divisions: 998,
            onChanged: (double val) => ref.read(calcOhmsLawController).setValueR1(val),
            addValue: (double val) => ref.read(calcOhmsLawController).addR1(val),
            switchFraction: (bool val) => ref.read(calcOhmsLawController).switchResistanceFraction(val),
            isFraction: ref.watch(calcOhmsLawResistanceFractionSwitch),
          ),
          CalcChooseUnitButtons(
            unitBase: '\u03a9',
            choosePrefix: (index) => ref.read(calcOhmsLawController).setPrefixR1(index),
            selectedIndex: ref.watch(calcOhmsLawController).unitIndexR1,
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
    final String valueI = ref.watch(calcOhmsLawDisplayValueI);
    final String valueR1 = ref.watch(calcOhmsLawDisplayValueR1);
    final String valueV1 = ref.watch(calcOhmsLawDisplayValueV1);
    return Row(
      children: [
        // const Expanded(child: SizedBox()),
        Expanded(
          // flex: 3,
          child: Text(
            '${valueI}A',
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
                Text('${valueV1}V', style: ohmsLawStyle),
                SizedBox(
                  width: 140,
                  child: Divider(
                    color: ohmsLawStyle?.color, //Theme.of(context).textTheme.headlineMedium?.color,
                    thickness: 3,
                  ),
                ),
                Text(
                  '$valueR1\u03a9',
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

