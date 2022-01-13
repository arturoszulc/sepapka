import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/utils/methods.dart';

import '../models/question.dart';


class DatabaseService {

  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  //CREATE NEW USER DOCUMENT IN DATABASE
  Future<void> createUserDB(String uid) async {
    return await usersCollection
        .doc(uid)
        .set({
      'qVersion': 0,
      'qListNew': [],
      'qListPractice': [],
      'qListNotShown': [],
    }).then((value) =>
        print('User created'));
  }



  // //UPDATE USER DATA
  Future<void> updateUser(LoggedUser user) async {
    return await usersCollection
        .doc(user.documentId)
        .set({
      userQVersion: user.qVersion,
      userQListNew: user.qListNew.map((e) => e.convertToMap()).toList(),
      userQListPractice: user.qListPractice.map((e) => e.convertToMap()).toList(),
      userQListNotShown: user.qListNotShown.map((e) => e.convertToMap()).toList(),
    }).then((value) =>
        print('User updated'));
  }


  // GET LOGGED USER DATA
  Future<LoggedUser?> getUserData(String uid) async {
    var doc = await usersCollection.doc(uid).get();
    return LoggedUser(
      documentId: doc.id,
      qVersion: doc.get(userQVersion),
      qListNew: List<QMap>.from(doc.get(userQListNew).map((e) => convertMapToQMap(e))),
      qListPractice: [],//doc.get(userQListPractice),
      qListNotShown: [],//doc.get(userQListNotShown),
    );
  }


  //Get question version
  Future<int?> getQuestionVersion() async {
    return questionVersionDB;
  }
  //Get question list
  Future<List<Question>> getQuestionList() async {
    return questionListDB.map((doc) {
      return Question(
          id: doc.id,
          q: doc.q,
          a1: doc.a1,
          a2: doc.a2,
          a3: doc.a3,
          a4: doc.a4,
          label: doc.label,
          level: doc.level);
    }).toList();
  }

  //Upload questions to DB ****** method on demand
  Future<void> uploadQuestions() async {

  }

}