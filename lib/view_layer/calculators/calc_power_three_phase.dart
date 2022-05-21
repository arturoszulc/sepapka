import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/colors.dart';
import 'package:sepapka/utils/custom_widgets/groupbutton_options.dart';
import 'dart:ui';

import '../../utils/consts/nav.dart';
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
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                          value: 1, groupValue: 'null', onChanged: (index) {}),
                      Expanded(
                        child: Text('Radio button 1'),
                      )
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                          value: 1, groupValue: 'null', onChanged: (index) {}),
                      Expanded(child: Text('Radio 2'))
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
            GroupButton(
              options: myGroupButtonOptions2(physicalWidth),
              isRadio: true,
              onSelected: (index, isSelected) => print('$index button is selected'),
              buttons: const ["W", "\u03A9"],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                              child: FloatingActionButton.small(
                                  onPressed: () {
                                    calcManager.setHeatingPowerCalcMode(false);
                                  },
                                  child: const Icon(
                                    Icons.arrow_left,
                                    size: 36,
                                  ))),
                          Expanded(
                            flex: 2,
                            child: Text(
                              calcMode ? 'Dobierz grzałki' : 'Oblicz moc',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: FloatingActionButton.small(
                                  onPressed: () {
                                    calcManager.setHeatingPowerCalcMode(true);
                                  },
                                  child: const Icon(
                                    Icons.arrow_right,
                                    size: 36,
                                  ))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: calcMode
                          ? const Text('Znam moc, chcę obliczyć potrzebną rezystancję grzałek')
                          : const Text('Mam już grzałki, chcę obliczyć ich moc'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: calcMode
                    ? buildResistanceCalculator(calcManager)
                    : buildPowerCalculator(context, calcManager),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPowerCalculator(BuildContext context, CalcManager calcManager) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: const Text(
              'Podaj rezystancję jednej grzałki [\u03A9]',
              textAlign: TextAlign.left,
              // style: TextStyle(color: mySecondary),
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
          ElevatedButton(
              onPressed: () {
                unfocus(context);
                calcManager.calculateHeatingPowerThreePhase();
              },
              child: const Text('Calculate power')),

          const SizedBox(height: 20,),
          calcManager.isResultVisible ? Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
              const Text('Wynik:', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('W układzie gwiazdy: ${calcManager.hptpCalc.starPower} W'),
              Text('W układzie trójkąta: ${calcManager.hptpCalc.deltaPower} W'),
            ],),
            ),
          ) : Container(),
        ],
      ),
    );
  }

  Widget buildResistanceCalculator(CalcManager calcManager) {
    return AnimatedContainer(
      color: Colors.green,
      duration: const Duration(seconds: 1),
    );
  }
}
