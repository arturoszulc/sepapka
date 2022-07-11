import 'dart:developer';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/methods.dart';

//Sliders switches
final calcOhmsLawResistanceFractionSwitch = StateProvider.autoDispose<bool>((ref) => false);
final calcOhmsLawVoltageFractionSwitch = StateProvider.autoDispose<bool>((ref) => false);

// //Units lists

final calcOhmsLawExponentR1 = StateProvider.autoDispose<int>((ref) => 0);
final calcOhmsLawWholePartR1 = StateProvider.autoDispose<double>((ref) => 500);
final calcOhmsLawFractionalPartR1 = StateProvider.autoDispose<double>((ref) => 00);
final calcOhmsLawCombinedR1 = Provider.autoDispose<double>((ref) {
  final double whole = ref.watch(calcOhmsLawWholePartR1);
  final double fractional = ref.watch(calcOhmsLawFractionalPartR1);
  return whole + (fractional/100);
});
final calcOhmsLawRealValueR1 = Provider.autoDispose<double>((ref) {
  final double combinedValue = ref.watch(calcOhmsLawCombinedR1);
  final int exponent = ref.watch(calcOhmsLawExponentR1);
  final double realValue = (combinedValue*pow(10,exponent));
  return realValue;
});
final calcOhmsLawDisplayValueR1 = Provider.autoDispose<String>((ref) {
  final double combinedValue = ref.watch(calcOhmsLawCombinedR1);
  final int exponent = ref.watch(calcOhmsLawExponentR1);
  String displayValue = convertNumberToDisplay(combinedValue, exponent);
  return displayValue;
});
//Voltage V1
final calcOhmsLawExponentV1 = StateProvider.autoDispose<int>((ref) => 0);
final calcOhmsLawWholePartV1 = StateProvider.autoDispose<double>((ref) => 500);
final calcOhmsLawFractionalPartV1 = StateProvider.autoDispose<double>((ref) => 00);
final calcOhmsLawCombinedV1 = Provider.autoDispose<double>((ref) {
  final double whole = ref.watch(calcOhmsLawWholePartV1);
  final double fractional = ref.watch(calcOhmsLawFractionalPartV1);
  return whole + (fractional/100);
});
final calcOhmsLawRealValueV1 = Provider.autoDispose<double>((ref) {
  final double combinedValue = ref.watch(calcOhmsLawCombinedV1);
  final int exponent = ref.watch(calcOhmsLawExponentV1);
  final double realValue = (combinedValue*pow(10,exponent));
  return realValue;
});
final calcOhmsLawDisplayValueV1 = Provider.autoDispose<String>((ref) {
  final double combinedValue = ref.watch(calcOhmsLawCombinedV1);
  final int exponent = ref.watch(calcOhmsLawExponentV1);
  String displayValue = convertNumberToDisplay(combinedValue, exponent);
  return displayValue;
});

//Current
final calcOhmsLawDisplayValueI = Provider.autoDispose<String>((ref) {
  //values
  final double r1 = ref.watch(calcOhmsLawRealValueR1);
  final double v1 = ref.watch(calcOhmsLawRealValueV1);
  //formula: I = V1/R1
  final double nominator = v1;
  final double denominator = r1;
  final String exponentialValue = (nominator/denominator).toStringAsExponential();

  final exp = int.parse(exponentialValue.split('e')[1]);

  final double number = double.parse(exponentialValue.split('e')[0]);
  String displayValue = convertNumberToDisplay(number, exp);
  return displayValue;
});

final calcOhmsLawController = Provider.autoDispose<CalcOhmsLawController>((ref) {
  return CalcOhmsLawController(ref);
});

class CalcOhmsLawController {
  final Ref _ref;
  CalcOhmsLawController(this._ref);


  int get unitIndexR1 => _ref.read(calcOhmsLawExponentR1)~/3+2;
  int get unitIndexV1 => _ref.read(calcOhmsLawExponentV1)~/3+2;

  setPrefixR1(int index)
  {
    int exponent = (index-2)*3;
    _ref.read(calcOhmsLawExponentR1.notifier).state = exponent;
  }
  setPrefixV1(int index)
  {
    int exponent = (index-2)*3;
    _ref.read(calcOhmsLawExponentV1.notifier).state = exponent;
  }

  setValueR1(double val) {
    final isFraction = _ref.read(calcOhmsLawResistanceFractionSwitch);
    if (isFraction) {
      _ref.read(calcOhmsLawFractionalPartR1.notifier).state = val;
    }
    else {
      _ref.read(calcOhmsLawWholePartR1.notifier).state = val;
    }
  }

  setValueV1(double val) {
    final isFraction = _ref.read(calcOhmsLawVoltageFractionSwitch);
    if (isFraction) {
      _ref.read(calcOhmsLawFractionalPartV1.notifier).state = val;
    }
    else {
      _ref.read(calcOhmsLawWholePartV1.notifier).state = val;
    }
  }

  addR1(double val) {
    final isFraction = _ref.read(calcOhmsLawResistanceFractionSwitch);
    if (isFraction) {
      final value = _ref.read(calcOhmsLawFractionalPartR1);
      if ((val<0 && value>0) || (val>0 && value<99)) _ref.read(calcOhmsLawFractionalPartR1.notifier).state+=val;
    }
    else {
      final value = _ref.read(calcOhmsLawWholePartR1);
      if ((val<0 && value>1) || (val>0 && value<999)) _ref.read(calcOhmsLawWholePartR1.notifier).state +=val;
    }
  }
  addV1(double val) {
    final isFraction = _ref.read(calcOhmsLawVoltageFractionSwitch);
    if (isFraction) {
      final value = _ref.read(calcOhmsLawFractionalPartV1);
      if ((val<0 && value>0) || (val>0 && value<99)) _ref.read(calcOhmsLawFractionalPartV1.notifier).state+=val;
    }
    else {
      final value = _ref.read(calcOhmsLawWholePartV1);
      if ((val<0 && value>1) || (val>0 && value<999)) _ref.read(calcOhmsLawWholePartV1.notifier).state +=val;
    }
  }

  switchResistanceFraction(bool isFraction) {
    _ref.read(calcOhmsLawResistanceFractionSwitch.notifier).state = isFraction;
  }

  switchVoltageFraction(bool isFraction) {
    _ref.read(calcOhmsLawVoltageFractionSwitch.notifier).state = isFraction;
  }

}