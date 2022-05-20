import 'dart:math';


class HeatingPowerThreePhaseCalc {

  final double voltagePhaseToNeutral = 230.0;
  final double voltagePhaseToPhase = 398.37;

  String errorMsg = '';
  bool mode = false;
  double heaterResistance = 50;

  String deltaPower = '';
  String starPower = '';

  bool calcPower() {
    if (heaterResistance == 0) {
      errorMsg = 'Wprowadź rezystancję grzałki';
      return false;
    }
    num power = 3 * (pow(voltagePhaseToNeutral, 2)/heaterResistance);
    starPower = power.toStringAsFixed(2);
    num power2 = 3 * (pow(voltagePhaseToPhase, 2)/heaterResistance);
    deltaPower = power2.toStringAsFixed(2);
    return true;
  }

  calcResistance() {

  }
}