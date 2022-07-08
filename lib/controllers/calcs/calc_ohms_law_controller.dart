import 'package:flutter_riverpod/flutter_riverpod.dart';


const unitPrefixes = ['\u00b5','m','','k','M'];

final calcOhmsLawResistanceUnit = StateProvider<String>((ref) => unitPrefixes[2]);
final calcOhmsLawVoltageUnit = StateProvider<String>((ref) => unitPrefixes[2]);

final calcOhmsLawResistanceValue = StateProvider<double>((ref) => 50);
final calcOhmsLawVoltageValue = StateProvider<double>((ref) => 50);
final calcOhmsLawCurrentValue = Provider<String>((ref) {
  final double resistance = ref.watch(calcOhmsLawResistanceValue);
  final double voltage = ref.watch(calcOhmsLawVoltageValue);
  return (voltage/resistance).toStringAsFixed(2);
});

final calcOhmsLawController = Provider<CalcOhmsLawController>((ref) {
  return CalcOhmsLawController(ref);
});

class CalcOhmsLawController {
  final Ref _ref;
  CalcOhmsLawController(this._ref);

  setResistanceUnit(int index)
  {
    _ref.read(calcOhmsLawResistanceUnit.notifier).state = unitPrefixes[index];
  }
  setVoltageUnit(int index)
  {
    _ref.read(calcOhmsLawVoltageUnit.notifier).state = unitPrefixes[index];
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