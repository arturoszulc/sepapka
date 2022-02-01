import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:sepapka/utils/methods.dart';

import '../models/question.dart';

class DatabaseService {
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('data');
  final CollectionReference questionsProCollection =
      FirebaseFirestore.instance.collection('questionsPro');
  final CollectionReference questionsFreeCollection =
      FirebaseFirestore.instance.collection('questionsFree');
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

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
    return await usersCollection.doc(user.documentId).set({
      userQVersion: user.qVersion,
      userUserName: user.userName,
      userIsPro: user.isPro,
      userRankTotalPoints: user.rankTotalPoints,
      userRankName: user.rankName,
      userQListNew1: user.qListNew1.map((e) => e.convertToMap()).toList(),
      userQListNew2: user.qListNew2.map((e) => e.convertToMap()).toList(),
      userQListNew3: user.qListNew3.map((e) => e.convertToMap()).toList(),
      userQListPractice: user.qListPractice.map((e) => e.convertToMap()).toList(),
      userQListNotShown: user.qListNotShown.map((e) => e.convertToMap()).toList(),
    }).then((value) => debugPrint('/// DB: User successfully updated ///'));
  }

  // GET LOGGED USER DATA
  Future<LoggedUser> getUserData(String uid) async {
    debugPrint('/// Downloading UserData from DB ///');
    var doc = await usersCollection.doc(uid).get();
    return LoggedUser(
      documentId: doc.id,
      userName: doc.get(userUserName),
      isPro: doc.get(userIsPro),
      rankTotalPoints: doc.get(userRankTotalPoints),
      rankName: doc.get(userRankName),
      qVersion: doc.get(userQVersion),
      qListNew1: List<QMap>.from(doc.get(userQListNew1).map((e) => convertMapToQMap(e))),
      qListNew2: List<QMap>.from(doc.get(userQListNew2).map((e) => convertMapToQMap(e))),
      qListNew3: List<QMap>.from(doc.get(userQListNew3).map((e) => convertMapToQMap(e))),
      qListPractice: List<QMap>.from(doc.get(userQListPractice).map((e) => convertMapToQMap(e))),
      qListNotShown: List<QMap>.from(doc.get(userQListNotShown).map((e) => convertMapToQMap(e))),
    );
  }

  //Get question version
  Future<int?> getQuestionVersion({required bool isPro}) async {
    var doc = await dataCollection.doc('8zhtbUQgofmxdaHyee3X').get();
    return isPro ? doc.get('qVersionPro') : doc.get('qVersionFree');
  }

  //Get question list (either Free or Pro user based on parameter)
  Future<List<Question>?> getQuestionList({required bool isPro}) async {
    debugPrint('/// Downloading question data from DB ///');
    var snapshot = isPro ? await questionsProCollection.get() : await questionsFreeCollection.get();
    return snapshot.docs.map((doc) {
      return Question(
          id: doc.id,
          q: doc.get(questionQ),
          a1: doc.get(questionA1),
          a2: doc.get(questionA2),
          a3: doc.get(questionA3),
          a4: doc.get(questionA4),
          labels: List<String>.from(doc.get(questionLabels)),
          level: doc.get(questionLevel),
          assetPath: doc.get(questionAssetPath));
    }).toList();
  }

  //Upload questions to DB ****** method on demand *******
  Future<void> uploadQuestions({required Question question, required bool isPro}) async {
    debugPrint('### ID IS ${question.id} ###');
    DocumentReference doc =
        isPro ? questionsProCollection.doc(question.id) : questionsFreeCollection.doc(question.id);
    return await doc.set({
      'q': question.q,
      'a1': question.a1,
      'a2': question.a2,
      'a3': question.a3,
      'a4': question.a4,
      'labels': [],
      'level': question.level,
      'assetPath': question.assetPath,
    });
  }
}
