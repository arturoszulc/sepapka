import 'dart:math';

import '../../utils/consts/numbers.dart';

class HeatingPowerThreePhaseCalc {

  String errorMsg = '';
  bool mode = false;
  double heaterResistance = 0;

  String starPowerTotal = '';
  String deltaPowerTotal = '';
  String starPowerSingle = '';
  String deltaPowerSingle = '';
  String starPhaseCurrent = '';
  String deltaPhaseCurrent = '';

  bool calcPower() {
    if (heaterResistance == 0) {
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
    deltaPhaseCurrent = (currentStar* sqrt(3)).toStringAsFixed(2);
    num powerDelta = (pow(voltagePhaseToPhase, 2)/heaterResistance);
    deltaPowerSingle = powerDelta.toStringAsFixed(2);
    deltaPowerTotal = (3*powerDelta).toStringAsFixed(2);
    return true;
  }

  calcResistance() {

  }
}