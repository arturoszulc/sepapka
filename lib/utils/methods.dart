import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/model_layer/models/question_map.dart';

import 'consts.dart';

convertMapToQMap(Map e) {
  return QMap(id: e['id'], dateModified: e['dateModified'], fibNum: e['fibNum']);
}

bool validatePassword(String value){
  String  pattern = r'^(?=.*?[0-9])(?=.*?[!@#\$&*~+-]).{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}


// addQuestionsToDb() async {
//   List myList = [
//     Question(q: 'Question 1',
//       a1: '1answer1',
//       a2: '1answer2',
//       a3: '1answer3',
//       a4: '1answer4',
//       labels: [],
//       level: 1,),
//     Question(q: 'Question 2',
//       a1: '2answer1',
//       a2: '2answer2',
//       a3: '2answer3',
//       a4: '2answer4',
//       labels: [],
//       level: 1,),
//     Question(q: 'Question 3',
//       a1: '3answer1',
//       a2: '3answer2',
//       a3: '3answer3',
//       a4: '3answer4',
//       labels: [],
//       level: 1,),
//     Question(q: 'Question 4',
//       a1: '4answer1',
//       a2: '4answer2',
//       a3: '4answer3',
//       a4: '4answer4',
//       labels: [],
//       level: 1,),
//   ];
//
//   for (var question in myList) {
//       return question;
//   }
// }