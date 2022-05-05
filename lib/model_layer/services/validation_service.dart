import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/models/validation.dart';

import '../../utils/consts/errors_messages.dart';

class ValidationService {
  ValidationModel _email = ValidationModel(null, null);
  ValidationModel _emailRemind = ValidationModel(null, null);
  ValidationModel _password = ValidationModel(null, null);
  ValidationModel _remark = ValidationModel(null, null);

  // bool _isEmailAndPasswordValid = false;

  final String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  // final String passwordPatternLength = r'^(?=.*?[0-9])(?=.*?[!@#\$&*~+-]).{8,}$';
  final String passwordPatternLength = r'.{8,}';
  final String passwordPatternComplexity = r'(.*?[a-zA-Z])(.*?[0-9])(.*?[!@#\$&*~+-])';
  final String remarkPattern = r'^[\s.,!?a-zA-ZżźćńółęąśŻŹĆĄŚĘŁÓŃ0-9-]+$';

  bool get isEmailAndPasswordValid {
    if (_email.value != null && _password.value != null) {
      return true;
    } else {
      return false;
    }
  }

  ValidationModel get email => _email;

  ValidationModel get emailRemind => _emailRemind;

  ValidationModel get password => _password;

  ValidationModel get remark => _remark;

  void validateEmail(String val) {
    bool emailValid = RegExp(emailPattern).hasMatch(val);
    if (!emailValid) {
      // if (val.isEmpty || !val.contains('@') || !val.contains('.\S')) {
      _email = ValidationModel(null, errorValEmail);
    } else {
      _email = ValidationModel(val, null);
    }
  }

  void validateEmailRemind(String val) {
    bool emailValid = RegExp(emailPattern).hasMatch(val);
    if (!emailValid) {
      // if (val.isEmpty || !val.contains('@') || !val.contains('.\S')) {
      _emailRemind = ValidationModel(null, errorValEmail);
    } else {
      _emailRemind = ValidationModel(val, null);
    }
  }

  void validatePassword(String val) {
    bool passwordValidLength = RegExp(passwordPatternLength).hasMatch(val);
    if (!passwordValidLength) {
      _password = ValidationModel(null, errorValPasswordLength);
      // return;
    } else {
      debugPrint('PASSED LENGTH VAL');
      bool passwordValidComplexity = RegExp(passwordPatternComplexity).hasMatch(val);
      if (!passwordValidComplexity) {
        _password = ValidationModel(null, errorValPasswordComplexity);
        // return;
      } else {
        _password = ValidationModel(val, null);
      }
    }
  }

  void validateRemark(String val) {
    bool remarkValid = RegExp(remarkPattern).hasMatch(val);
    if (!remarkValid) {
      if (val.isEmpty) {
        _remark = ValidationModel(null, null);
      } else {
        _remark = ValidationModel(null, errorRemarkChars);
      }
    }
    else {
      _remark = ValidationModel(val, null);
    }
  }
}
