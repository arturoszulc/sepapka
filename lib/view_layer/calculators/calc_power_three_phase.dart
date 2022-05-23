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
    bool calcMode = context.read<CalcManager>().hptpCalc.mode;
    return GestureDetector(
      onTap: () {
        debugPrint('gesture detector tapped');
        unFocus(context);
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.read<Manager>().navigate(Screen.menu);
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
            child: TextField(
              style: Theme.of(context).textTheme.headline6,
              // textAlign: TextAlign.right,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                calcManager.hptpCalc.heaterResistance = val.isEmpty ? 0.0 : double.parse(val);
              },
              onTap: () => calcManager.hideResult(),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
              child: Text(
                calcManager.calcError.toString(),
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  unFocus(context);
                  calcManager.hptpCalc.mode = false;
                  calcManager.calculateHeatingPowerThreePhase();
                },
                child: const Text('Oblicz moc')),
          ),
          const SizedBox(
            height: 20,
          ),
          calcManager.isResultVisible
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text('Wynik', style: Theme.of(context).textTheme.headline6,),
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
            child: TextField(
              style: Theme.of(context).textTheme.headline6,
              // textAlign: TextAlign.right,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                calcManager.hptpCalc.heaterPower = val.isEmpty ? 0.0 : double.parse(val);
              },
              onTap: () => calcManager.hideResult(),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
              child: Text(
                calcManager.calcError.toString(),
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  unFocus(context);
                  calcManager.hptpCalc.mode = true;
                  calcManager.calculateHeatingPowerThreePhase();
                },
                child: const Text('Oblicz rezystancję')),
          ),
          const SizedBox(
            height: 20,
          ),
          calcManager.isResultVisible
              ? Expanded(
            child: SingleChildScrollView(
              child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text('Wynik', style: Theme.of(context).textTheme.headline6,),
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
