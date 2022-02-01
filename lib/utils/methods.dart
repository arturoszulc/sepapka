import 'dart:math';

import 'package:sepapka/model_layer/models/question_map.dart';


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