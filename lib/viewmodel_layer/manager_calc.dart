import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/calcs/heating_power_three_phase_calc_model.dart';


class CalcManager extends ChangeNotifier {

  final bool calcIsReady = true;
  String calcError = '';
  bool isResultVisible = false;


  setCalcError(String? msg) {
    if (msg == null) {
      calcError = '';
    } else {
      calcError = msg;
    }
    notifyListeners();
  }

  // hideResult() {
  //   // isResultVisible = false;
  //   hptpCalc.clear();
  //   // notifyListeners();
  // }
  //
  // showResult() {
  //   isResultVisible = true;
  // }


  //HEATING POWER THREE PHASE - HPTP

  HeatingPowerThreePhaseCalc hptpCalc = HeatingPowerThreePhaseCalc();

  void hptpCalcPower() {
    //calculate power
    hptpCalc.calcPower();
    notifyListeners();
  }

  void hptpCalcResistance() {
    //calculate heater resistance
    hptpCalc.calcResistance();
    notifyListeners();
  }

}