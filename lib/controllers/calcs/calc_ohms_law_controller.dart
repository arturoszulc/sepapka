import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';


const selectableUnitPrefixes = ['\u00b5','m','','k','M'];
const calculatedUnitPrefixes = ['p','n','\u00b5','m','','k','M','G','T'];

final calcOhmsLawResistanceFractionSwitch = StateProvider.autoDispose<bool>((ref) => false);


final calcOhmsLawResistanceUnitIndex = StateProvider.autoDispose<int>((ref) => 2);
final calcOhmsLawVoltageUnitIndex = StateProvider.autoDispose<int>((ref) => 2);

final calcOhmsLawCurrentUnitIndex = Provider.autoDispose<int>((ref) {

  final int resistanceUnitIndex = ref.watch(calcOhmsLawResistanceUnitIndex)-2;
  final int voltageUnitIndex = ref.watch(calcOhmsLawVoltageUnitIndex)-2;
  int currentUnitIndex = 4;
  currentUnitIndex = currentUnitIndex + voltageUnitIndex - resistanceUnitIndex;
  return currentUnitIndex;
});

final calcOhmsLawResistanceWholePart = StateProvider<double>((ref) => 50);
final calcOhmsLawResistanceFractionalPart = StateProvider<double>((ref) => 15);
final calcOhmsLawResistanceVal = Provider<double>((ref) {
  final double whole = ref.watch(calcOhmsLawResistanceWholePart);
  final double fractional = ref.watch(calcOhmsLawResistanceFractionalPart);
  final double value = whole + (fractional/100);
  return value;
});

final calcOhmsLawVoltageValue = StateProvider.autoDispose<double>((ref) => 50);
final calcOhmsLawCurrentValue = Provider.autoDispose<String>((ref) {
  final double resistance = ref.watch(calcOhmsLawResistanceVal);
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
    _ref.read(calcOhmsLawVoltageValue.notifier).state = val;
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
    // _ref.read(calcOhmsLawVoltageValue.notifier).state = _ref.read(calcOhmsLawVoltageValue.notifier).state + val;
  }

  switchResistanceFraction(bool isFraction) {
    _ref.read(calcOhmsLawResistanceFractionSwitch.notifier).state = isFraction;
  }

}