import 'dart:math';

import 'package:sepapka/model_layer/models/question_map.dart';

import 'api_status.dart';
import 'consts.dart';
import 'consts/errors_messages.dart';


convertMapToQMap(Map e) {
  return QMap(id: e['id'], dateModified: e['dateModified'], fibNum: e['fibNum']);
}

String getRandomString(int length){
  const ch = '01234567890AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  Random r = Random.secure();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
}

Object validateEmail(String email) {
  if (email.isEmpty || !email.contains('@')) return Failure(errorValEmail);
  return Success();
}

Object validatePassword(String password){
  String  pattern = r'^(?=.*?[0-9])(?=.*?[!@#\$&*~+-]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(password)) return Failure(errorValPassword);
  return Success();
}

Object validateUsername(String username) {
  //check if length is between 3-16 chars
  if (username.length < 3 || username.length > 16) return Failure(errorUsernameLength);

  //username should contain only alphanumeric characters
  String  pattern = r'^[a-zA-ZżźćńółęąśŻŹĆĄŚĘŁÓŃ0-9-]+$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(username)) return Failure(errorUsernameCharValidation);
  return Success();
}

Object validateRemark(String remark) {
  //check if length is more than 3 chars
  if (remark.length < 3) return Failure(errorRemarkTooShort);

  //remark should contain only alphanumeric characters
  String  pattern = r'^[\s.,!?a-zA-ZżźćńółęąśŻŹĆĄŚĘŁÓŃ0-9-]+$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(remark)) return Failure(errorRemarkChars);
  return Success();

}