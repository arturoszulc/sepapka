import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../utils/consts/nav.dart';

import '../../viewmodel_layer/manager.dart';
import '../../viewmodel_layer/manager_calc.dart';

class CalcPowerThreePhase extends StatelessWidget {
  const CalcPowerThreePhase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CalcManager calcManager = Provider.of<CalcManager>(context);

    return Scaffold(
      // backgroundColor: myPrimaryLight,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              context.read<Manager>().navigate(Screen.menu);
            },
          ),
        ),
        body: Center(child: Column(
          children: [
            const Text('R1'),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (val) {
                calcManager.powerThreePhaseR1 = double.tryParse(val)!;
              },
            ),
            const Text('R2'),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (val) {
                calcManager.powerThreePhaseR2 = double.tryParse(val)!;
              },
            ),
            const Text('R3'),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (val) {
                calcManager.powerThreePhaseR3 = double.tryParse(val)!;
              },
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              calcManager.powerThreePhaseStar();
            }, child: Text('Calculate')),
            const SizedBox(height: 20,),
            const Text('Result'),
            Text('${calcManager.powerThreePhaseResult}'),
          ],
        )));
  }
}
