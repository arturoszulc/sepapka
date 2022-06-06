import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../utils/consts/numbers.dart';

class HeatingPowerThreePhaseCalc {


  //power calc variables
  String inputPowerErrorMsg = '';
  String inputPower = '';
  double parsedPower = 0;
  String starPhaseCurrent = '';
  String deltaPhaseCurrent = '';
  String starPowerSingle = '';
  String deltaPowerSingle = '';
  String starPowerTotal = '';
  String deltaPowerTotal = '';

  //resistance calc variables
  String inputResistanceErrorMsg = '';
  String inputResistance = '';
  double parsedResistance = 0;
  String starPhaseCurrent2 = '';
  String deltaPhaseCurrent2 = '';





  String starResistance = '';
  String deltaResistance = '';


  void clearCalcPower() {
    starPowerTotal = '';
    deltaPowerTotal = '';
  }

  void clearCalcResistance() {
    starResistance = '';
    deltaResistance = '';
  }

  
  double? parseStringToDouble(String value) {
    value = value.replaceAll(' ', '');
    debugPrint('Removing spaces: $value');

    value = value.replaceAll(',', '.');
    debugPrint('Removing commas: $value');
    // value = value.replaceAll('-', '');
    debugPrint('Removing dashes: $value');
    return double.tryParse(value);
  }

  bool calcPower() {
    //parse resistance
    double? parseResult = parseStringToDouble(inputResistance);
    debugPrint('Parse result: $parseResult');
    if (parseResult == null || parseResult <= 0.0) {
      inputPowerErrorMsg = 'Wprowadzona wartość musi być liczbą wymierną, większą od 0.';
      return false;
    } else {
      inputPowerErrorMsg = '';
      parsedResistance = parseResult;
    }
    //calculate star
    num currentStar = voltagePhaseToNeutral / parsedResistance;
    starPhaseCurrent = currentStar.toStringAsFixed(2);
    num powerStar = (pow(voltagePhaseToNeutral, 2)/parsedResistance);
    starPowerSingle = powerStar.toStringAsFixed(2);
    starPowerTotal = (3 * powerStar).toStringAsFixed(2);

    //calculate delta
    num currentDelta = (voltagePhaseToPhase) / parsedResistance;
    deltaPhaseCurrent = (currentDelta*sqrt(3)).toStringAsFixed(2);
    num powerDelta = (pow(voltagePhaseToPhase, 2)/parsedResistance);
    deltaPowerSingle = powerDelta.toStringAsFixed(2);
    deltaPowerTotal = (3*powerDelta).toStringAsFixed(2);
    return true;
  }

  calcResistance() {
    //parse power
    double? parseResult = parseStringToDouble(inputPower);
    debugPrint('ParsedPower result: $parseResult');

    if (parseResult == null || parseResult <= 0.0) {
      inputResistanceErrorMsg = 'Wprowadzona wartość musi być liczbą wymierną, większą od 0.';
      return false;
    } else {
      inputResistanceErrorMsg = '';
      parsedPower = parseResult;
    }
    //calculate star
    num resistanceStar = 3*(pow(voltagePhaseToNeutral, 2)/parsedPower);
    starResistance = resistanceStar.toStringAsFixed(2);

    num currentStar = voltagePhaseToNeutral/resistanceStar;
    starPhaseCurrent2 = currentStar.toStringAsFixed(2);

    //calculate delta
    num resistanceDelta = 3*(pow(voltagePhaseToPhase, 2)/parsedPower);
    deltaResistance = resistanceDelta.toStringAsFixed(2);

    num currentDelta = sqrt(3)*(voltagePhaseToPhase/resistanceDelta);
    deltaPhaseCurrent2 = currentDelta.toStringAsFixed(2);

    return true;
  }
}