import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/utils/methods.dart';
import 'package:flutter/foundation.dart';

import '../models/question.dart';


class DatabaseService {

  final CollectionReference dataCollection =
  FirebaseFirestore.instance.collection('data');
  final CollectionReference questionsCollection =
  FirebaseFirestore.instance.collection('questions');
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');



  //CREATE NEW USER DOCUMENT IN DATABASE
  // Future<void> createUserDB(String uid) async {
  //   return await usersCollection
  //       .doc(uid)
  //       .set({
  //     'qVersion': 0,
  //     'qListNew': [],
  //     'qListPractice': [],
  //     'qListNotShown': [],
  //   }).then((value) =>
  //       print('User created'));
  // }


  // //UPDATE USER DATA
  Future<void> updateUser(LoggedUser user) async {
    return await usersCollection
        .doc(user.documentId)
        .set({
      userQVersion: user.qVersion,
      userIsPro: user.isPro,
      userQListNew1: user.qListNew1.map((e) => e.convertToMap()).toList(),
      userQListNew2: user.qListNew2.map((e) => e.convertToMap()).toList(),
      userQListNew3: user.qListNew3.map((e) => e.convertToMap()).toList(),
      userQListPractice: user.qListPractice.map((e) => e.convertToMap()).toList(),
      userQListNotShown: user.qListNotShown.map((e) => e.convertToMap()).toList(),
    }).then((value) =>
        debugPrint('/// DB: User updated ///'));
  }


  // GET LOGGED USER DATA
  Future<LoggedUser> getUserData(String uid) async {
    var doc = await usersCollection.doc(uid).get();
    return LoggedUser(
      documentId: doc.id,
      isPro: doc.get(userIsPro),
      qVersion: doc.get(userQVersion),
      qListNew1: List<QMap>.from(doc.get(userQListNew1).map((e) => convertMapToQMap(e))),
      qListNew2: List<QMap>.from(doc.get(userQListNew2).map((e) => convertMapToQMap(e))),
      qListNew3: List<QMap>.from(doc.get(userQListNew3).map((e) => convertMapToQMap(e))),
      qListPractice: List<QMap>.from(doc.get(userQListPractice).map((e) => convertMapToQMap(e))),
      qListNotShown: List<QMap>.from(doc.get(userQListNotShown).map((e) => convertMapToQMap(e))),
    );
  }


  //Get question version
  Future<int?> getQuestionVersion() async {
    var doc = await dataCollection.doc('8zhtbUQgofmxdaHyee3X').get();
    return doc.get('qVersion');
  }

  //Get question list
  Future<List<Question>?> getQuestionList() async {
    debugPrint('/// Downloading question data from DB ///');
    var snapshot = await questionsCollection.get();
    return snapshot.docs.map((doc) {
      return Question(
          id: doc.id,
          q: doc.get(questionQ),
          a1: doc.get(questionA1),
          a2: doc.get(questionA2),
          a3: doc.get(questionA3),
          a4: doc.get(questionA4),
          labels: List<String>.from(doc.get(questionLabels)),
          level: doc.get(questionLevel));
    }).toList();
  }

  //Upload questions to DB ****** method on demand
  Future<void> uploadQuestions(Question question) async {
    return questionsCollection
        .doc().set({
      'q': question.q,
      'a1': question.a1,
      'a2': question.a2,
      'a3': question.a3,
      'a4': question.a4,
      'labels': [],
      'level': question.level,
    });
  }

}