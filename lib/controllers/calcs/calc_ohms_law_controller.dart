import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

//Sliders switches
final calcOhmsLawResistanceFractionSwitch = StateProvider.autoDispose<bool>((ref) => false);
final calcOhmsLawVoltageFractionSwitch = StateProvider.autoDispose<bool>((ref) => false);

//Units lists
const selectableUnitPrefixes = ['\u00b5','m','','k','M'];
const calculatedUnitPrefixes = ['p','n','\u00b5','m','','k','M','G','T'];
//Units
final calcOhmsLawResistanceUnitIndex = StateProvider.autoDispose<int>((ref) => 2);
final calcOhmsLawVoltageUnitIndex = StateProvider.autoDispose<int>((ref) => 2);
final calcOhmsLawCurrentUnitIndex = Provider.autoDispose<int>((ref) {

  final int resistanceUnitIndex = ref.watch(calcOhmsLawResistanceUnitIndex)-2;
  final int voltageUnitIndex = ref.watch(calcOhmsLawVoltageUnitIndex)-2;
  int currentUnitIndex = 4;
  currentUnitIndex = currentUnitIndex + voltageUnitIndex - resistanceUnitIndex;
  return currentUnitIndex;
});
//Resistance
final calcOhmsLawResistanceWholePart = StateProvider.autoDispose<double>((ref) => 500);
final calcOhmsLawResistanceFractionalPart = StateProvider.autoDispose<double>((ref) => 00);
final calcOhmsLawResistanceValue = Provider.autoDispose<double>((ref) {
  final double whole = ref.watch(calcOhmsLawResistanceWholePart);
  final double fractional = ref.watch(calcOhmsLawResistanceFractionalPart);
  final double value = whole + (fractional/100);
  return value;
});
//Voltage
final calcOhmsLawVoltageWholePart = StateProvider.autoDispose<double>((ref) => 230);
final calcOhmsLawVoltageFractionalPart = StateProvider.autoDispose<double>((ref) => 0);
final calcOhmsLawVoltageValue = Provider.autoDispose<double>((ref) {
  final double whole = ref.watch(calcOhmsLawVoltageWholePart);
  final double fractional = ref.watch(calcOhmsLawVoltageFractionalPart);
  final double value = whole + (fractional/100);
  return value;
});

//Current
final calcOhmsLawCurrentValue = Provider.autoDispose<String>((ref) {
  final double resistance = ref.watch(calcOhmsLawResistanceValue);
  final double voltage = ref.watch(calcOhmsLawVoltageValue);
  return (voltage/resistance).toStringAsFixed(2);
});

final calcOhmsLawController = Provider.autoDispose<CalcOhmsLawController>((ref) {
  return CalcOhmsLawController(ref);
});

class CalcOhmsLawController {
  final Ref _ref;
  CalcOhmsLawController(this._ref);


  setResistanceUnitIndex(int index)
  {
    _ref.read(calcOhmsLawResistanceUnitIndex.notifier).state = index;
  }
  setVoltageUnitIndex(int index)
  {
    _ref.read(calcOhmsLawVoltageUnitIndex.notifier).state = index;
  }

  setResistanceValue(double val) {
    final isFraction = _ref.read(calcOhmsLawResistanceFractionSwitch);
    if (isFraction) {
      _ref.read(calcOhmsLawResistanceFractionalPart.notifier).state = val;
    }
    else {
      _ref.read(calcOhmsLawResistanceWholePart.notifier).state = val;
    }
  }

  setVoltageValue(double val) {
    final isFraction = _ref.read(calcOhmsLawVoltageFractionSwitch);
    if (isFraction) {
      _ref.read(calcOhmsLawVoltageFractionalPart.notifier).state = val;
    }
    else {
      _ref.read(calcOhmsLawVoltageWholePart.notifier).state = val;
    }
  }

  addResistance(double val) {
    final isFraction = _ref.read(calcOhmsLawResistanceFractionSwitch);
    if (isFraction) {
      _ref.read(calcOhmsLawResistanceFractionalPart.notifier).state += val;
    }
    else {
      _ref.read(calcOhmsLawResistanceWholePart.notifier).state += val;
    }
  }
  addVoltage(double val) {
    final isFraction = _ref.read(calcOhmsLawVoltageFractionSwitch);
    if (isFraction) {
      _ref.read(calcOhmsLawVoltageFractionalPart.notifier).state += val;
    }
    else {
      _ref.read(calcOhmsLawVoltageWholePart.notifier).state += val;
    }
  }

  switchResistanceFraction(bool isFraction) {
    _ref.read(calcOhmsLawResistanceFractionSwitch.notifier).state = isFraction;
  }

  switchVoltageFraction(bool isFraction) {
    _ref.read(calcOhmsLawVoltageFractionSwitch.notifier).state = isFraction;
  }

}