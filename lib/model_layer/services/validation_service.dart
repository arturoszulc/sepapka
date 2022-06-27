import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/models/input_validation_model.dart';

import '../../utils/consts/errors_messages.dart';


final validationService = Provider<ValidationService>((ref) {
  return ValidationService();
});

class ValidationService {


  final String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  final String passwordPatternLength = r'.{6,}';
  final String remarkPattern = r'^[\s.,!?a-zA-ZżźćńółęąśŻŹĆĄŚĘŁÓŃ0-9-]+$';

  // bool isEmailRemindValid(InputValidationModel email) {
  //   if (email.value != null) return true;
  //   return false;
  // }

  bool isEmailAndPasswordValid(InputValidationModel email, InputValidationModel password) {
    if (email.value != null && password.value != null) {
      return true;
    } else {
      return false;
    }
  }

  // InputValidationModel get email => _email;

  // InputValidationModel get emailRemind => _emailRemind;

  // InputValidationModel get password => _password;

  // InputValidationModel get remark => _remark;

  InputValidationModel validateEmail(String val) {
    bool emailValid = RegExp(emailPattern).hasMatch(val);
    if (!emailValid) {
      return const InputValidationModel(null, errorValEmail);
    } else {
      return InputValidationModel(val, null);
    }
  }

  InputValidationModel validateEmailRemind(String val) {
    bool emailValid = RegExp(emailPattern).hasMatch(val);
    if (!emailValid) {
      return const InputValidationModel(null, errorValEmail);
    } else {
      return InputValidationModel(val, null);
    }
  }

  InputValidationModel validatePassword(String val) {
    bool passwordValidLength = RegExp(passwordPatternLength).hasMatch(val);
    if (!passwordValidLength) {
      return const InputValidationModel(null, errorValPasswordLength);
      } else {
      return InputValidationModel(val, null);
      }
    }


  InputValidationModel validateRemark(String val) {
    bool remarkValid = RegExp(remarkPattern).hasMatch(val);
    if (!remarkValid) {
      if (val.isEmpty) {
        return const InputValidationModel(null, null);
      } else {
        return const InputValidationModel(null, errorRemarkChars);
      }
    }
    else {
      return InputValidationModel(val, null);
    }
  }
}
