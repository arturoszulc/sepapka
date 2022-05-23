import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../utils/consts/numbers.dart';

class HeatingPowerThreePhaseCalc {

  String errorMsg = '';
  bool mode = false;
  double heaterResistance = 0;
  double heaterPower = 0;

  String starPowerTotal = '';
  String deltaPowerTotal = '';
  String starPowerSingle = '';
  String deltaPowerSingle = '';
  String starPhaseCurrent = '';
  String deltaPhaseCurrent = '';

  String starResistance = '';
  String deltaResistance = '';

  void clear() {
    heaterResistance = 0;
    heaterPower = 0;

    starPowerTotal = '';
    deltaPowerTotal = '';
    starPowerSingle = '';
    deltaPowerSingle = '';
    starPhaseCurrent = '';
    deltaPhaseCurrent = '';

    starResistance = '';
    deltaResistance = '';
  }


  bool calcPower() {
    if (heaterResistance <= 0) {
      errorMsg = 'Wprowadź rezystancję grzałki';
      return false;
    }
    //calculate star
    num currentStar = voltagePhaseToNeutral / heaterResistance;
    starPhaseCurrent = currentStar.toStringAsFixed(2);
    num powerStar = (pow(voltagePhaseToNeutral, 2)/heaterResistance);
    starPowerSingle = powerStar.toStringAsFixed(2);
    starPowerTotal = (3 * powerStar).toStringAsFixed(2);

    //calculate delta
    num currentDelta = (voltagePhaseToPhase) / heaterResistance;
    deltaPhaseCurrent = (currentDelta*sqrt(3)).toStringAsFixed(2);
    num powerDelta = (pow(voltagePhaseToPhase, 2)/heaterResistance);
    deltaPowerSingle = powerDelta.toStringAsFixed(2);
    deltaPowerTotal = (3*powerDelta).toStringAsFixed(2);
    return true;
  }

  calcResistance() {
    if (heaterPower <= 0) {
      errorMsg = 'Moc musi być większa od 0';
      return false;
    }
    //calculate star
    num resistanceStar = 3*(pow(voltagePhaseToNeutral, 2)/heaterPower);
    starResistance = resistanceStar.toStringAsFixed(2);

    num currentStar = voltagePhaseToNeutral/resistanceStar;
    starPhaseCurrent = currentStar.toStringAsFixed(2);

    //calculate delta
    num resistanceDelta = 3*(pow(voltagePhaseToPhase, 2)/heaterPower);
    deltaResistance = resistanceDelta.toStringAsFixed(2);

    num currentDelta = sqrt(3)*(voltagePhaseToPhase/resistanceDelta);
    deltaPhaseCurrent = currentDelta.toStringAsFixed(2);

    return true;
  }
}