import 'dart:math';

import 'package:sepapka/model_layer/models/question_map.dart';

import 'api_status.dart';
import 'consts.dart';


convertMapToQMap(Map e) {
  return QMap(id: e['id'], dateModified: e['dateModified'], fibNum: e['fibNum']);
}

String getRandomString(int length){
  const ch = '01234567890AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  Random r = Random.secure();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
}

bool validatePassword(String value){
  String  pattern = r'^(?=.*?[0-9])(?=.*?[!@#\$&*~+-]).{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

Object validateUsername(String username) {
  //check if length is between 3-16 chars
  if (username.length < 3 || username.length > 16) return Failure(usernameLengthError);

  //username should contain only alphanumeric characters
  String  pattern = r'^[a-zA-ZżźćńółęąśŻŹĆĄŚĘŁÓŃ0-9-]+$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(username)) return Failure(usernameCharValidationError);
  return Success();
}