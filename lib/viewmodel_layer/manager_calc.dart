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

  hideResult() {
    isResultVisible = false;
    // notifyListeners();
  }

  showResult() {
    isResultVisible = true;
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
      if (!isSuccess) {
        setCalcError(hptpCalc.errorMsg);
      } else {
        showResult();
        // notifyListeners();
      }

    }
    else {
      //calculate heater resistance
    }
  }



}