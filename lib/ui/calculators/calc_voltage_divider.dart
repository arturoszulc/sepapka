
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/utils/methods.dart';

import '../../controllers/calcs/calc_voltage_divider_controller.dart';
import '../../utils/custom_widgets/build_question_image.dart';
import 'calc_ohms_law.dart';

class CalcVoltageDivider extends ConsumerWidget {
  const CalcVoltageDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String val = convertNumberToDisplay(2.0, -6);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Dzielnik napięcia'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: VoltageDividerVisualisation(),
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                    child: TabBar(tabs: [
                      Tab(text: 'U1'),
                      Tab(text: 'R1'),
                      Tab(text: 'R2'),
                    ]),
                  ),
                  Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          CalcSlider(
                            name: 'Napięcie U1',
                            value: ref.watch(calcVoltageDividerFractionSwitchV1)
                                ? ref.watch(calcVoltageDividerFractionalPartV1)
                                : ref.watch(calcVoltageDividerWholePartV1),
                            min: 1,
                            max: 999,
                            divisions: 998,
                            onChanged: (val) =>
                                ref.read(calcVoltageDividerController).setValueV1(val),
                            addValue: (val) => ref.read(calcVoltageDividerController).addV1(val),
                            switchFraction: (bool val) =>
                                ref.read(calcVoltageDividerController).switchFractionV1(val),
                            isFraction: ref.watch(calcVoltageDividerFractionSwitchV1),
                          ),
                          CalcChooseUnitButtons(
                              unitBase: 'V',
                              choosePrefix: (index) =>
                                  ref.read(calcVoltageDividerController).setPrefixV1(index),
                              selectedIndex: ref.watch(calcVoltageDividerController).unitIndexV1),
                        ],
                      ),
                      Column(children: [
                        const SizedBox(
                          height: 30,
                        ),
                        CalcSlider(
                          name: 'Rezystancja R1',
                          value: ref.watch(calcVoltageDividerFractionSwitchR1)
                              ? ref.watch(calcVoltageDividerFractionalPartR1)
                              : ref.watch(calcVoltageDividerWholePartR1),
                          min: 1,
                          max: 999,
                          divisions: 998,
                          onChanged: (val) =>
                              ref.read(calcVoltageDividerController).setValueR1(val),
                          addValue: (val) => ref.read(calcVoltageDividerController).addR1(val),
                          switchFraction: (bool val) =>
                              ref.read(calcVoltageDividerController).switchFractionR1(val),
                          isFraction: ref.watch(calcVoltageDividerFractionSwitchR1),
                        ),
                        CalcChooseUnitButtons(
                          unitBase: '\u03a9',
                          choosePrefix: (index) =>
                              ref.read(calcVoltageDividerController).setPrefixR1(index),
                          selectedIndex: ref.watch(calcVoltageDividerController).unitIndexR1,
                        ),
                      ]),
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          CalcSlider(
                            name: 'Rezystancja R2',
                            value: ref.watch(calcVoltageDividerFractionSwitchR2)
                                ? ref.watch(calcVoltageDividerFractionalPartR2)
                                : ref.watch(calcVoltageDividerWholePartR2),
                            min: 1,
                            max: 999,
                            divisions: 998,
                            onChanged: (val) =>
                                ref.read(calcVoltageDividerController).setValueR2(val),
                            addValue: (val) => ref.read(calcVoltageDividerController).addR2(val),
                            switchFraction: (bool val) =>
                                ref.read(calcVoltageDividerController).switchFractionR2(val),
                            isFraction: ref.watch(calcVoltageDividerFractionSwitchR2),
                          ),
                          CalcChooseUnitButtons(
                            unitBase: '\u03a9',
                            choosePrefix: (index) =>
                                ref.read(calcVoltageDividerController).setPrefixR2(index),
                            selectedIndex: ref.watch(calcVoltageDividerController).unitIndexR2,
                          ),
                        ],
                      ),
                    ],
                  ))
                ],
              ),
            ),
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
    final double height = MediaQuery.of(context).size.width * 0.5;
    final double paddingVertical = height * 0.04;

    final String valueV1 = ref.watch(calcVoltageDividerDisplayValueV1);
    final String valueR1 = ref.watch(calcVoltageDividerDisplayValueR1);
    final String valueR2 = ref.watch(calcVoltageDividerDisplayValueR2);
    final String valueV2 = ref.watch(calcVoltageDividerDisplayValueV2);

    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          buildImage(context, 'assets/images/calcs/voltage-divider.png'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: height * 0.1, vertical: paddingVertical),
            child: Row(
              children: [
                //voltage input
                Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '$valueR1\u03a9',
                                  textAlign: TextAlign.right,
                                  style: voltageDividerStyle,
                                ))),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '$valueR2\u03a9',
                                  textAlign: TextAlign.right,
                                  style: voltageDividerStyle,
                                ))),
                      ],
                    )),
                Expanded(
                    flex: 9,
                    child: Column(
                      children: [
                        const Expanded(child: SizedBox()),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${valueV2}V',
                                  textAlign: TextAlign.right,
                                  style: voltageDividerStyle,
                                ))),
                      ],
                    )),
                //resistances
                //voltage output
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: height * 0.1, vertical: paddingVertical),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${valueV1}V',
                  textAlign: TextAlign.left,
                  style: voltageDividerStyle,
                )),
          ),
        ],
      ),
    );
  }
}
