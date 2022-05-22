import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/consts/nav.dart';
import '../../utils/custom_widgets/build_question_image.dart';
import '../../viewmodel_layer/manager.dart';
import '../../viewmodel_layer/manager_calc.dart';

class CalcHeatingPowerThreePhase extends StatelessWidget {
  const CalcHeatingPowerThreePhase({Key? key}) : super(key: key);

  void unfocus(BuildContext context) {
    debugPrint('tapped gesture detector');
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
    final double width = MediaQuery.of(context).size.width;
    final Size physicalScreenSize = window.physicalSize;
    final double physicalWidth = physicalScreenSize.width;
    double physicalHeight = physicalScreenSize.height;
    debugPrint(calcMode.toString());
    return GestureDetector(
      onTap: () {
        unfocus(context);
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
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
                debugPrint(val);
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
                  unfocus(context);
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
                            const Text(
                              'Wynik:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                                children: [
                                  Expanded(child: buildQuestionImage(context, 'assets/images/knowledge_base/three_phase_power/star.png')),
                                  Expanded(child: Column(children: [
                                    Text('Ip = ${calcManager.hptpCalc.starPhaseCurrent}'),
                                    Text('Pr = ${calcManager.hptpCalc.starPowerSingle}'),
                                    Text('Pstar = ${calcManager.hptpCalc.starPowerTotal}'),
                                  ],),),
                                ]
                            ),
                            Row(children: [
                              Expanded(child: buildQuestionImage(context, 'assets/images/knowledge_base/three_phase_power/delta.png')),
                              Expanded(child: Column(children: [
                                Text('Ip = ${calcManager.hptpCalc.deltaPhaseCurrent} A'),
                                Text('Pr = ${calcManager.hptpCalc.deltaPowerSingle} W'),
                                Text('Pdelta = ${calcManager.hptpCalc.deltaPowerTotal} W'),
                              ],),),
                            ],),
                          ],
                        ),
                      )
                  ),
                ),
              )
              : Container(),
        ],
      ),
    );
  }

  Widget buildResistanceCalculator(BuildContext context, CalcManager calcManager) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              'Kalkulator w przygotowaniu...',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
