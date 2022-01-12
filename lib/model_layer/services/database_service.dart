import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/utils/consts.dart';

import '../models/question.dart';


class DatabaseService {

  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  //CREATE USER DOCUMENT IN DATABASE
  Future<void> createUser(String uid) async {
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
      userQListNew: user.qListNew,
      userQListPractice: user.qListPractice,
      userQListNotShown: user.qListNotShown,
    }).then((value) =>
        print('User updated'));
  }


  // GET LOGGED USER DATA
  Future<LoggedUser?> getUserData(String uid) async {
    var doc = await usersCollection.doc(uid).get();
    return LoggedUser(
      documentId: doc.id,
      qVersion: doc.get(userQVersion),
      qListNew: List<QMap>.from(doc.get(userQListNew)),
      qListPractice: List<QMap>.from(doc.get(userQListPractice)),
      qListNotShown: List<QMap>.from(doc.get(userQListNotShown)),
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

}