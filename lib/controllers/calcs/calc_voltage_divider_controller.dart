import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

//Sliders switches
final calcVoltageDividerFractionSwitchR1 = StateProvider.autoDispose<bool>((ref) => false);
final calcVoltageDividerFractionSwitchR2 = StateProvider.autoDispose<bool>((ref) => false);
final calcVoltageDividerFractionSwitchV1 = StateProvider.autoDispose<bool>((ref) => false);

//Units lists
const selectableUnitPrefixes = ['\u00b5','m','','k','M'];
const calculatedUnitPrefixes = ['p','n','\u00b5','m','','k','M','G','T'];
//Units
final calcVoltageDividerUnitIndexR2 = StateProvider.autoDispose<int>((ref) => 2);
final calcVoltageDividerUnitIndexV1 = StateProvider.autoDispose<int>((ref) => 2);
final calcVoltageDividerUnitIndexV2 = Provider.autoDispose<int>((ref) {

  final int unitIndexR2 = ref.watch(calcVoltageDividerUnitIndexR2)-2;
  final int unitIndexV1 = ref.watch(calcVoltageDividerUnitIndexV1)-2;
  int unitIndexV2 = 4;
  unitIndexV2 = unitIndexV2 + unitIndexV1 - unitIndexR2;
  return unitIndexV2;
});
//Resistance
final calcVoltageDividerResistanceWholePart = StateProvider.autoDispose<double>((ref) => 500);
final calcVoltageDividerResistanceFractionalPart = StateProvider.autoDispose<double>((ref) => 00);
final calcVoltageDividerResistanceValue = Provider.autoDispose<double>((ref) {
  final double whole = ref.watch(calcVoltageDividerResistanceWholePart);
  final double fractional = ref.watch(calcVoltageDividerResistanceFractionalPart);
  final double value = whole + (fractional/100);
  return value;
});
//Voltage
final calcVoltageDividerVoltageWholePart = StateProvider.autoDispose<double>((ref) => 230);
final calcVoltageDividerVoltageFractionalPart = StateProvider.autoDispose<double>((ref) => 0);
final calcVoltageDividerVoltageValue = Provider.autoDispose<double>((ref) {
  final double whole = ref.watch(calcVoltageDividerVoltageWholePart);
  final double fractional = ref.watch(calcVoltageDividerVoltageFractionalPart);
  final double value = whole + (fractional/100);
  return value;
});

//Current
final calcVoltageDividerCurrentValue = Provider.autoDispose<String>((ref) {
  final double resistance = ref.watch(calcVoltageDividerResistanceValue);
  final double voltage = ref.watch(calcVoltageDividerVoltageValue);
  return (voltage/resistance).toStringAsFixed(2);
});

final calcVoltageDividerController = Provider.autoDispose<CalcVoltageDividerController>((ref) {
  return CalcVoltageDividerController(ref);
});

class CalcVoltageDividerController {
  final Ref _ref;
  CalcVoltageDividerController(this._ref);


  setResistanceUnitIndex(int index)
  {
    _ref.read(calcVoltageDividerUnitIndexR2.notifier).state = index;
  }
  setVoltageUnitIndex(int index)
  {
    _ref.read(calcVoltageDividerUnitIndexV1.notifier).state = index;
  }

  setResistanceValue(double val) {
    final isFraction = _ref.read(calcVoltageDividerFractionSwitchR1);
    if (isFraction) {
      _ref.read(calcVoltageDividerResistanceFractionalPart.notifier).state = val;
    }
    else {
      _ref.read(calcVoltageDividerResistanceWholePart.notifier).state = val;
    }
  }

  setVoltageValue(double val) {
    final isFraction = _ref.read(calcVoltageDividerFractionSwitchV1);
    if (isFraction) {
      _ref.read(calcVoltageDividerVoltageFractionalPart.notifier).state = val;
    }
    else {
      _ref.read(calcVoltageDividerVoltageWholePart.notifier).state = val;
    }
  }

  addResistance(double val) {
    final isFraction = _ref.read(calcVoltageDividerFractionSwitchR1);
    if (isFraction) {
      _ref.read(calcVoltageDividerResistanceFractionalPart.notifier).state += val;
    }
    else {
      _ref.read(calcVoltageDividerResistanceWholePart.notifier).state += val;
    }
  }
  addVoltage(double val) {
    final isFraction = _ref.read(calcVoltageDividerFractionSwitchV1);
    if (isFraction) {
      _ref.read(calcVoltageDividerVoltageFractionalPart.notifier).state += val;
    }
    else {
      _ref.read(calcVoltageDividerVoltageWholePart.notifier).state += val;
    }
  }

  switchResistanceFraction(bool isFraction) {
    _ref.read(calcVoltageDividerFractionSwitchR1.notifier).state = isFraction;
  }

  switchVoltageFraction(bool isFraction) {
    _ref.read(calcVoltageDividerFractionSwitchV1.notifier).state = isFraction;
  }

}