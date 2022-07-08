import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';


const selectableUnitPrefixes = ['\u00b5','m','','k','M'];
const calculatedUnitPrefixes = ['p','n','\u00b5','m','','k','M','G','T'];

final calcOhmsLawResistanceUnit = StateProvider.autoDispose<String>((ref) => selectableUnitPrefixes[2]);
final calcOhmsLawVoltageUnit = StateProvider.autoDispose<String>((ref) => selectableUnitPrefixes[2]);
final calcOhmsLawCurrentUnit = Provider.autoDispose<String>((ref) {
  final String resistanceUnit = ref.watch(calcOhmsLawResistanceUnit);
  final String voltageUnit = ref.watch(calcOhmsLawVoltageUnit);
  final int resistanceUnitIndex = selectableUnitPrefixes.indexOf(resistanceUnit)-2;
  final int voltageUnitIndex = selectableUnitPrefixes.indexOf(voltageUnit)-2;
  int currentUnitIndex = 4;
  currentUnitIndex = currentUnitIndex + voltageUnitIndex - resistanceUnitIndex;
  log('currentIndex: $currentUnitIndex');
  return calculatedUnitPrefixes[currentUnitIndex];
});

final calcOhmsLawResistanceValue = StateProvider.autoDispose<double>((ref) => 50);
final calcOhmsLawVoltageValue = StateProvider.autoDispose<double>((ref) => 50);
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

  setResistanceUnit(int index)
  {
    _ref.read(calcOhmsLawResistanceUnit.notifier).state = selectableUnitPrefixes[index];
  }
  setVoltageUnit(int index)
  {
    _ref.read(calcOhmsLawVoltageUnit.notifier).state = selectableUnitPrefixes[index];
  }

  setResistanceValue(double val) {
    _ref.read(calcOhmsLawResistanceValue.notifier).state = val;
  }

  setVoltageValue(double val) {
    _ref.read(calcOhmsLawVoltageValue.notifier).state = val;
  }

  addResistance(double val) {
   _ref.read(calcOhmsLawResistanceValue.notifier).state = _ref.read(calcOhmsLawResistanceValue.notifier).state + val;
  }
  addVoltage(double val) {
    _ref.read(calcOhmsLawVoltageValue.notifier).state = _ref.read(calcOhmsLawVoltageValue.notifier).state + val;
  }
}