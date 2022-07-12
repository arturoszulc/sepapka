import 'dart:developer' as log;
import 'dart:math';

class UnitPrefix {
  final int exponent;
  final String prefix;
  final int multiplication;

  const UnitPrefix(this.exponent, this.prefix, this.multiplication);

  factory UnitPrefix.empty() => const UnitPrefix(0, '', 0);
}

const List<UnitPrefix> listOfPrefixes = [
  UnitPrefix(-24, 'y', 0),
  UnitPrefix(-23, 'y', 1),
  UnitPrefix(-22, 'y', 2),
  UnitPrefix(-21, 'z', 0),
  UnitPrefix(-20, 'z', 1),
  UnitPrefix(-19, 'z', 2),
  UnitPrefix(-18, 'a', 0),
  UnitPrefix(-17, 'a', 1),
  UnitPrefix(-16, 'a', 2),
  UnitPrefix(-15, 'f', 0),
  UnitPrefix(-14, 'f', 1),
  UnitPrefix(-13, 'f', 2),
  UnitPrefix(-12, 'p', 0),
  UnitPrefix(-11, 'p', 1),
  UnitPrefix(-10, 'p', 2),
  UnitPrefix(-9, 'n', 0),
  UnitPrefix(-8, 'n', 1),
  UnitPrefix(-7, 'n', 2),
  UnitPrefix(-6, '\u00b5', 0),
  UnitPrefix(-5, '\u00b5', 1),
  UnitPrefix(-4, '\u00b5', 2),
  UnitPrefix(-3, 'm', 0),
  UnitPrefix(-2, 'm', 1),
  UnitPrefix(-1, 'm', 2),
  UnitPrefix(0, '', 0),
  UnitPrefix(1, '', 1),
  UnitPrefix(2, '', 2),
  UnitPrefix(3, 'k', 0),
  UnitPrefix(4, 'k', 1),
  UnitPrefix(5, 'k', 2),
  UnitPrefix(6, 'M', 0),
  UnitPrefix(7, 'M', 1),
  UnitPrefix(8, 'M', 2),
  UnitPrefix(9, 'G', 0),
  UnitPrefix(10, 'G', 1),
  UnitPrefix(11, 'G', 2),
  UnitPrefix(12, 'T', 0),
  UnitPrefix(13, 'T', 1),
  UnitPrefix(14, 'T', 2),
  UnitPrefix(15, 'P', 0),
  UnitPrefix(16, 'P', 1),
  UnitPrefix(17, 'P', 2),
  UnitPrefix(18, 'E', 0),
  UnitPrefix(19, 'E', 1),
  UnitPrefix(20, 'E', 2),
  UnitPrefix(21, 'Z', 0),
  UnitPrefix(22, 'Z', 1),
  UnitPrefix(23, 'Z', 2),
  UnitPrefix(24, 'Y', 0),
  UnitPrefix(25, 'Y', 1),
  UnitPrefix(26, 'Y', 2),
];

String convertNumberToDisplay(double number, int exponent) {

   final UnitPrefix unitPrefix = listOfPrefixes.firstWhere((prefix) => prefix.exponent == exponent);
   final newNumber = (number*pow(10, unitPrefix.multiplication)).toStringAsFixed(2);
   final prefix = unitPrefix.prefix;
   final displayNumber = '$newNumber $prefix';
   return displayNumber;
}


// import 'dart:math';
//
// import 'package:sepapka/trash/question_map.dart';
//
// import 'api_status.dart';
// // import 'consts/strings.dart';
// import 'consts/errors_messages.dart';


// convertMapToQMap(Map e) {
//   return QMap(id: e['id'], dateModified: e['dateModified'], fibNum: e['fibNum']);
// }

// String getRandomString(int length){
//   const ch = '01234567890AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
//   Random r = Random.secure();
//   return String.fromCharCodes(Iterable.generate(
//       length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
// }

// Object validateEmail(String email) {
//   if (email.isEmpty || !email.contains('@')) return Failure(errorValEmail);
//   return Success();
// }

// Object validatePassword(String password){
//   String  pattern = r'^(?=.*?[0-9])(?=.*?[!@#\$&*~+-]).{8,}$';
//   RegExp regExp = RegExp(pattern);
//   if (!regExp.hasMatch(password)) return Failure(errorValPasswordLength);
//   return Success();
// }

// Object validateUsername(String username) {
//   //check if length is between 3-16 chars
//   if (username.length < 3 || username.length > 16) return Failure(errorUsernameLength);
//
//   //username should contain only alphanumeric characters
//   String  pattern = r'^[a-zA-ZżźćńółęąśŻŹĆĄŚĘŁÓŃ0-9-]+$';
//   RegExp regExp = RegExp(pattern);
//   if (!regExp.hasMatch(username)) return Failure(errorUsernameCharValidation);
//   return Success();
// }

// Object validateRemark(String remark) {
//   //check if length is more than 3 chars
//   if (remark.length < 3) return Failure(errorRemarkTooShort);
//
//   //remark should contain only alphanumeric characters
//   String  pattern = r'^[\s.,!?a-zA-ZżźćńółęąśŻŹĆĄŚĘŁÓŃ0-9-]+$';
//   RegExp regExp = RegExp(pattern);
//   if (!regExp.hasMatch(remark)) return Failure(errorRemarkChars);
//   return Success();
//
// }