import 'dart:developer' as log;
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/methods.dart';

//Sliders switches
final calcVoltageDividerFractionSwitchV1 = StateProvider.autoDispose<bool>((ref) => false);
final calcVoltageDividerFractionSwitchR1 = StateProvider.autoDispose<bool>((ref) => false);
final calcVoltageDividerFractionSwitchR2 = StateProvider.autoDispose<bool>((ref) => false);

//Resistance R1
final calcVoltageDividerExponentR1 = StateProvider.autoDispose<int>((ref) => 0);
final calcVoltageDividerWholePartR1 = StateProvider.autoDispose<double>((ref) => 500);
final calcVoltageDividerFractionalPartR1 = StateProvider.autoDispose<double>((ref) => 00);
final calcVoltageDividerCombinedR1 = Provider.autoDispose<double>((ref) {
  final double whole = ref.watch(calcVoltageDividerWholePartR1);
  final double fractional = ref.watch(calcVoltageDividerFractionalPartR1);
  return whole + (fractional/100);
});
final calcVoltageDividerRealValueR1 = Provider.autoDispose<double>((ref) {
  final double combinedValue = ref.watch(calcVoltageDividerCombinedR1);
  final int exponent = ref.watch(calcVoltageDividerExponentR1);
  final double realValue = (combinedValue*pow(10,exponent));
  return realValue;
});
final calcVoltageDividerDisplayValueR1 = Provider.autoDispose<String>((ref) {
  final double combinedValue = ref.watch(calcVoltageDividerCombinedR1);
  final int exponent = ref.watch(calcVoltageDividerExponentR1);
  String displayValue = convertNumberToDisplay(combinedValue, exponent);
  return displayValue;
});

//Resistance R2
final calcVoltageDividerExponentR2 = StateProvider.autoDispose<int>((ref) => 0);
final calcVoltageDividerWholePartR2 = StateProvider.autoDispose<double>((ref) => 500);
final calcVoltageDividerFractionalPartR2 = StateProvider.autoDispose<double>((ref) => 00);
final calcVoltageDividerCombinedR2 = Provider.autoDispose<double>((ref) {
  final double whole = ref.watch(calcVoltageDividerWholePartR2);
  final double fractional = ref.watch(calcVoltageDividerFractionalPartR2);
  return whole + (fractional/100);
});
final calcVoltageDividerRealValueR2 = Provider.autoDispose<double>((ref) {
  final double combinedValue = ref.watch(calcVoltageDividerCombinedR2);
  final int exponent = ref.watch(calcVoltageDividerExponentR2);
  final double realValue = (combinedValue*pow(10,exponent));
  return realValue;
});
final calcVoltageDividerDisplayValueR2 = Provider.autoDispose<String>((ref) {
  final double combinedValue = ref.watch(calcVoltageDividerCombinedR2);
  final int exponent = ref.watch(calcVoltageDividerExponentR2);
  String displayValue = convertNumberToDisplay(combinedValue, exponent);
  return displayValue;
});

//Voltage V1
final calcVoltageDividerExponentV1 = StateProvider.autoDispose<int>((ref) => 0);
final calcVoltageDividerWholePartV1 = StateProvider.autoDispose<double>((ref) => 500);
final calcVoltageDividerFractionalPartV1 = StateProvider.autoDispose<double>((ref) => 00);
final calcVoltageDividerCombinedV1 = Provider.autoDispose<double>((ref) {
  final double whole = ref.watch(calcVoltageDividerWholePartV1);
  final double fractional = ref.watch(calcVoltageDividerFractionalPartV1);
  return whole + (fractional/100);
});
final calcVoltageDividerRealValueV1 = Provider.autoDispose<double>((ref) {
  final double combinedValue = ref.watch(calcVoltageDividerCombinedV1);
  final int exponent = ref.watch(calcVoltageDividerExponentV1);
  final double realValue = (combinedValue*pow(10,exponent));
  return realValue;
});
final calcVoltageDividerDisplayValueV1 = Provider.autoDispose<String>((ref) {
  final double combinedValue = ref.watch(calcVoltageDividerCombinedV1);
  final int exponent = ref.watch(calcVoltageDividerExponentV1);
  String displayValue = convertNumberToDisplay(combinedValue, exponent);
  return displayValue;
});

//Voltage V2
final calcVoltageDividerDisplayValueV2 = Provider.autoDispose<String>((ref) {
  //values
  final double r1 = ref.watch(calcVoltageDividerRealValueR1);
  final double r2 = ref.watch(calcVoltageDividerRealValueR2);
  final double v1 = ref.watch(calcVoltageDividerRealValueV1);
  //formula: V2 = V1*R2 / (R1 + R2)
  final double nominator = v1*r2;
  final double denominator = r1+r2;
  final String exponentialValue = (nominator/denominator).toStringAsExponential();

  final exp = int.parse(exponentialValue.split('e')[1]);

  final double number = double.parse(exponentialValue.split('e')[0]);
  String displayValue = convertNumberToDisplay(number, exp);
  return displayValue;
});

final calcVoltageDividerController = Provider.autoDispose<CalcVoltageDividerController>((ref) {
  return CalcVoltageDividerController(ref);
});

class CalcVoltageDividerController {
  final Ref _ref;
  CalcVoltageDividerController(this._ref);

  int get unitIndexR1 => _ref.read(calcVoltageDividerExponentR1)~/3+2;
  int get unitIndexR2 => _ref.read(calcVoltageDividerExponentR2)~/3+2;
  int get unitIndexV1 => _ref.read(calcVoltageDividerExponentV1)~/3+2;

  //indexes
  setPrefixR1(int index)
  {
    int exponent = (index-2)*3;
    _ref.read(calcVoltageDividerExponentR1.notifier).state = exponent;
  }
  setPrefixR2(int index)
  {
    int exponent = (index-2)*3;
    _ref.read(calcVoltageDividerExponentR2.notifier).state = exponent;
  }
  setPrefixV1(int index)
  {
    int exponent = (index-2)*3;
    _ref.read(calcVoltageDividerExponentV1.notifier).state = exponent;
  }

  //values
  setValueR1(double val) {
    final isFraction = _ref.read(calcVoltageDividerFractionSwitchR1);
    if (isFraction) {
      _ref.read(calcVoltageDividerFractionalPartR1.notifier).state = val;
    }
    else {
      _ref.read(calcVoltageDividerWholePartR1.notifier).state = val;
    }
  }

  setValueR2(double val) {
    final isFraction = _ref.read(calcVoltageDividerFractionSwitchR2);
    if (isFraction) {
      _ref.read(calcVoltageDividerFractionalPartR2.notifier).state = val;
    }
    else {
      _ref.read(calcVoltageDividerWholePartR2.notifier).state = val;
    }
  }

  setValueV1(double val) {
    final isFraction = _ref.read(calcVoltageDividerFractionSwitchV1);
    if (isFraction) {
      _ref.read(calcVoltageDividerFractionalPartV1.notifier).state = val;
    }
    else {
      _ref.read(calcVoltageDividerWholePartV1.notifier).state = val;
    }
  }

  addR1(double val) {
    final isFraction = _ref.read(calcVoltageDividerFractionSwitchR1);
    if (isFraction) {
      final value = _ref.read(calcVoltageDividerFractionalPartR1);
      if ((val<0 && value>0) || (val>0 && value<99)) _ref.read(calcVoltageDividerFractionalPartR1.notifier).state+=val;
    }
    else {
      final value = _ref.read(calcVoltageDividerWholePartR1);
      if ((val<0 && value>1) || (val>0 && value<999)) _ref.read(calcVoltageDividerWholePartR1.notifier).state +=val;
    }
  }
  addR2(double val) {
    final isFraction = _ref.read(calcVoltageDividerFractionSwitchR2);
    if (isFraction) {
      final value = _ref.read(calcVoltageDividerFractionalPartR2);
      if ((val<0 && value>0) || (val>0 && value<99)) _ref.read(calcVoltageDividerFractionalPartR2.notifier).state+=val;
    }
    else {
      final value = _ref.read(calcVoltageDividerWholePartR2);
      if ((val<0 && value>1) || (val>0 && value<999)) _ref.read(calcVoltageDividerWholePartR2.notifier).state +=val;
    }
  }
  addV1(double val) {
    final isFraction = _ref.read(calcVoltageDividerFractionSwitchV1);
    if (isFraction) {
      final value = _ref.read(calcVoltageDividerFractionalPartV1);
      if ((val<0 && value>0) || (val>0 && value<99)) _ref.read(calcVoltageDividerFractionalPartV1.notifier).state+=val;
    }
    else {
      final value = _ref.read(calcVoltageDividerWholePartV1);
      if ((val<0 && value>1) || (val>0 && value<999)) _ref.read(calcVoltageDividerWholePartV1.notifier).state +=val;
    }
  }

  switchFractionR1(bool isFraction) {
    _ref.read(calcVoltageDividerFractionSwitchR1.notifier).state = isFraction;
  }
  switchFractionR2(bool isFraction) {
    _ref.read(calcVoltageDividerFractionSwitchR2.notifier).state = isFraction;
  }

  switchFractionV1(bool isFraction) {
    _ref.read(calcVoltageDividerFractionSwitchV1.notifier).state = isFraction;
  }

}