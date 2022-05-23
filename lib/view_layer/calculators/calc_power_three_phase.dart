import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/consts/nav.dart';
import '../../utils/custom_widgets/build_question_image.dart';
import '../../viewmodel_layer/manager.dart';
import '../../viewmodel_layer/manager_calc.dart';

class CalcHeatingPowerThreePhase extends StatelessWidget {
  const CalcHeatingPowerThreePhase({Key? key}) : super(key: key);

  void unFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('*** CalcHeatingPowerThreePhase built ***');
    final CalcManager calcManager = Provider.of<CalcManager>(context);
    return GestureDetector(
        onTap: () {
          debugPrint('gesture detector tapped');
          unFocus(context);
        },
        child: DefaultTabController(
          length: 2,
          child: WillPopScope(
            onWillPop: () {
              return context.read<Manager>().navigate(Screen.calcMenu);
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.read<Manager>().navigate(Screen.calcMenu);
                  },
                ),
                title: const Text('Moc grzania 3-f'),
                centerTitle: true,
                bottom: const TabBar(tabs: [
                  Tab(text: '[W]'),
                  Tab(text: '[\u03A9]'),
                ]),
              ),
              body: TabBarView(children: [
                buildPowerCalculator(context, calcManager),
                buildResistanceCalculator(context, calcManager),
                // buildRankTop(context),
                // buildRankUser(context),
              ]),
            ),
          ),
        ),
      );
  }

  Widget buildPowerCalculator(BuildContext context, CalcManager calcManager) {
    debugPrint('*** buildPowerCalculator rebuilt ***');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              'Podaj rezystancję jednej grzałki [\u03A9]',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFormField(
              initialValue: calcManager.hptpCalc.inputResistance,
              maxLength: 10,
              style: Theme.of(context).textTheme.headline6,
              // textAlign: TextAlign.right,
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                calcManager.hptpCalc.inputResistance = val;
              },
              onTap: () => calcManager.hptpCalc.clearCalcPower(),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 5.0, left: 15, right: 15),
              child: Text(
                calcManager.hptpCalc.inputPowerErrorMsg,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  unFocus(context);
                  calcManager.hptpCalcPower();
                },
                child: const Text('Oblicz moc')),
          ),
          const SizedBox(
            height: 20,
          ),
          calcManager.hptpCalc.starPowerTotal.isNotEmpty
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text('Wynik dla R = ${calcManager.hptpCalc.parsedResistance} \u03A9', style: Theme.of(context).textTheme.headline6,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  'Połączenie w gwiazdę\n U = 230 V',
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: buildQuestionImage(context,
                                        'assets/images/knowledge_base/three_phase_power/star.png')),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Prąd przewodowy:',
                              ),
                              Text('${calcManager.hptpCalc.starPhaseCurrent} A',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Moc jednej grzałki:'),
                              Text('${calcManager.hptpCalc.starPowerSingle} W'),
                            ],
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            const Text('Moc całego układu:'),
                            Text('${calcManager.hptpCalc.starPowerTotal} W'),
                          ]),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20.0),
                            height: 3,
                            width: 200,
                            color: Colors.grey[300],
                          ),
                          Row(
                            children: [
                              Text(
                                'Połączenie w trójkąt\n U = 400 V',
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: buildQuestionImage(context,
                                      'assets/images/knowledge_base/three_phase_power/delta.png')),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Prąd przewodowy:',
                              ),
                              Text('${calcManager.hptpCalc.deltaPhaseCurrent} A',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Moc jednej grzałki:'),
                              Text('${calcManager.hptpCalc.deltaPowerSingle} W'),
                            ],
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Moc całego układu:'),
                                Text('${calcManager.hptpCalc.deltaPowerTotal} W'),
                              ]),

                        ],
                      ),
                    )),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget buildResistanceCalculator(BuildContext context, CalcManager calcManager) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              'Podaj planowaną moc układu [W]',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextFormField(
              initialValue: calcManager.hptpCalc.inputPower,
              maxLength: 10,
              style: Theme.of(context).textTheme.headline6,
              // textAlign: TextAlign.right,
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                calcManager.hptpCalc.inputPower = val;
              },
              onTap: () => calcManager.hptpCalc.clearCalcResistance(),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 5.0, left: 15, right: 15),
              child: Text(
                calcManager.hptpCalc.inputResistanceErrorMsg,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  unFocus(context);
                  calcManager.hptpCalcResistance();
                },
                child: const Text('Oblicz rezystancję')),
          ),
          const SizedBox(
            height: 20,
          ),
          calcManager.hptpCalc.starResistance.isNotEmpty
              ? Expanded(
            child: SingleChildScrollView(
              child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text('Wynik dla P = ${calcManager.hptpCalc.parsedPower} W', style: Theme.of(context).textTheme.headline6,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            children: [
                              Text(
                                'Połączenie w gwiazdę\n U = 230 V',
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: buildQuestionImage(context,
                                      'assets/images/knowledge_base/three_phase_power/star.png')),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Prąd przewodowy:',
                            ),
                            Text('${calcManager.hptpCalc.starPhaseCurrent2} A',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Rezystancja jednej grzałki:'),
                            Text('${calcManager.hptpCalc.starResistance} \u03A9'),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20.0),
                          height: 3,
                          width: 200,
                          color: Colors.grey[300],
                        ),
                        Row(
                          children: [
                            Text(
                              'Połączenie w trójkąt\n U = 400 V',
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            ),
                            Expanded(
                                flex: 1,
                                child: buildQuestionImage(context,
                                    'assets/images/knowledge_base/three_phase_power/delta.png')),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Prąd przewodowy:',
                            ),
                            Text('${calcManager.hptpCalc.deltaPhaseCurrent2} A',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Rezystancja jednej grzałki:'),
                            Text('${calcManager.hptpCalc.deltaResistance} \u03A9'),
                          ],
                        ),

                      ],
                    ),
                  )),
            ),
          )
              : Container(),
        ],
      ),
    );

  }
}
