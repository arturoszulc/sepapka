import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/calcs/heating_power_three_phase_calc_model.dart';


class CalcManager extends ChangeNotifier {

  final bool calcIsReady = true;
  String? calcError;


  setCalcError(String? msg) {
    if (msg == null) {
      calcError = '';
    } else {
      calcError = msg;
    }
    notifyListeners();
  }


  //HEATING POWER THREE PHASE - HPTP

  HeatingPowerThreePhaseCalc hptpCalc = HeatingPowerThreePhaseCalc();

  void setHeatingPowerCalcMode(bool mode) {
    hptpCalc.mode = mode;
    notifyListeners();
  }

  void calculateHeatingPowerThreePhase() {
    setCalcError(null);
    if (!hptpCalc.mode) {
      //calculate power
      bool isSuccess = hptpCalc.calcPower();
      if (!isSuccess) setCalcError(hptpCalc.errorMsg);
      debugPrint('StarPower = ${hptpCalc.starPower} W');
      debugPrint('DeltaPower = ${hptpCalc.deltaPower} W');

    }
    else {
      //calculate heater resistance
    }
  }



}