import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/consts/nav.dart';
import '../../viewmodel_layer/manager.dart';
import '../../viewmodel_layer/manager_calc.dart';

class CalcHeatingPowerThreePhase extends StatelessWidget {
  const CalcHeatingPowerThreePhase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CalcManager calcManager = Provider.of<CalcManager>(context);
    bool calcMode = context.read<CalcManager>().hptpCalc.mode;
    debugPrint(calcMode.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.read<Manager>().navigate(Screen.menu);
          },
        ),
        title: const Text('Moc grzania 3-f'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
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
                    : buildPowerCalculator(calcManager)),
          ],
        ),
      ),
    );
  }

  Widget buildPowerCalculator(CalcManager calcManager) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          AnimatedContainer(
            curve: Curves.easeInCirc,
            color: Colors.green,
            width: calcManager.hptpCalc.heaterResistance,
            height: 200,
            duration: const Duration(milliseconds: 500),),
          const Text(
            'Podaj rezystancję jednej grzałki [\u03A9]',
            textAlign: TextAlign.left,
          ),
          TextField(
            // textAlign: TextAlign.right,
            decoration: const InputDecoration(
              // label: Text('Rezystancja grzałki'),
              // hintText: 'np. 2000',
              suffix: Text('\u03A9'),
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) {
              debugPrint(val);
              calcManager.hptpCalc.heaterResistance = val.isEmpty ? 0.0 : double.parse(val);
            },
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
                calcManager.calculateHeatingPowerThreePhase();
              },
              child: const Text('Calculate power')),
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
