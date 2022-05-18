import 'package:flutter/material.dart';


class CalcManager extends ChangeNotifier {

  final bool calcIsReady = true;

  final double voltagePhaseToNeutral = 230.0;
  final double voltagePhaseToPhase = 400.0;

  double resistanceThreePhaseR1 = 0;
  double resistanceThreePhaseR2 = 0;
  double resistanceThreePhaseR3 = 0;

  double powerThreePhaseR1 = 0;
  double powerThreePhaseR2 = 0;
  double powerThreePhaseR3 = 0;
  double powerThreePhaseP1 = 0;
  double powerThreePhaseP2 = 0;
  double powerThreePhaseP3 = 0;
  double powerThreePhaseResult = 0;

  void powerThreePhaseStar() {
    powerThreePhaseP1 = (voltagePhaseToNeutral * voltagePhaseToNeutral) / powerThreePhaseR1;
    debugPrint(powerThreePhaseP1.toString());
    powerThreePhaseP2 = (voltagePhaseToNeutral * voltagePhaseToNeutral) / powerThreePhaseR2;
    powerThreePhaseP3 = (voltagePhaseToNeutral * voltagePhaseToNeutral) / powerThreePhaseR3;
    powerThreePhaseResult = powerThreePhaseP1 + powerThreePhaseP2 + powerThreePhaseP3;
    notifyListeners();
  }

  void powerThreePhaseDelta() {

    powerThreePhaseResult = 15.0;
    notifyListeners();
  }

}