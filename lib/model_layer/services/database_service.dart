import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sepapka/model_layer/models/global_data.dart';
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


  // //UPDATE USER DATA
  Future<void> updateUser(LoggedUser user) async {
    debugPrint('/// DB: writing USER doc... ///');
    return await usersCollection.doc(user.documentId).set({
      userQVersion: user.qVersion,
      userUsername: user.username,
      userIsPro: user.isPro,
      userRankLevel: user.rankLevel,
      userRankTotalPoints: user.rankTotalPoints,
      userQListNew1: user.qListNew1.map((e) => e.convertToMap()).toList(),
      userQListNew2: user.qListNew2.map((e) => e.convertToMap()).toList(),
      userQListNew3: user.qListNew3.map((e) => e.convertToMap()).toList(),
      userQListPractice: user.qListPractice.map((e) => e.convertToMap()).toList(),
      userQListNotShown: user.qListNotShown.map((e) => e.convertToMap()).toList(),
    }).then((value) => debugPrint('/// DB: User successfully updated ///'));
  }

  // GET LOGGED USER DATA
  Future<LoggedUser> getUserData(String uid) async {
    debugPrint('/// DB: reading USER doc... ///');
    var doc = await usersCollection.doc(uid).get();
    return LoggedUser(
      documentId: doc.id,
      username: doc.get(userUsername),
      isPro: doc.get(userIsPro),
      rankLevel: doc.get(userRankLevel),
      rankTotalPoints: doc.get(userRankTotalPoints),
      qVersion: doc.get(userQVersion),
      qListNew1: List<QMap>.from(doc.get(userQListNew1).map((e) => convertMapToQMap(e))),
      qListNew2: List<QMap>.from(doc.get(userQListNew2).map((e) => convertMapToQMap(e))),
      qListNew3: List<QMap>.from(doc.get(userQListNew3).map((e) => convertMapToQMap(e))),
      qListPractice: List<QMap>.from(doc.get(userQListPractice).map((e) => convertMapToQMap(e))),
      qListNotShown: List<QMap>.from(doc.get(userQListNotShown).map((e) => convertMapToQMap(e))),
    );
  }

  // VERIFY if theres user with the same Username
  Future<bool> checkIfUsernameIsAvailable(String userId, String username) async {
    debugPrint('/// DB: reading all USER docs... ///');
    var snapshot = await usersCollection.get();
    if (snapshot.metadata.isFromCache) throw Exception(errorDbConnection);
    for (var doc in snapshot.docs) {
      if (doc.id != userId) //avoid comparing currentUser - it's username will always match
      {
        if (doc.get('username') == username) return false;
      }
    }
    return true;
  }

  //Get GlobalData document
  Future<GlobalData> getGlobalData() async {
    debugPrint('/// DB: reading DATA doc... ///');
    var doc = await dataCollection.doc('8zhtbUQgofmxdaHyee3X').get();
    return GlobalData(
      qVersionFree: doc.get(globalDataQVersionFree),
      qVersionPro: doc.get(globalDataQVersionPro),
      rankNames: List<String>.from(doc.get(globalDataRankNames)),
      rankThresholds: List<int>.from(doc.get(globalDataRankThresholds)),
    );
  }
  
  // //Get question version
  // Future<int?> getQuestionVersion({required bool isPro}) async {
  //   var doc = await dataCollection.doc('8zhtbUQgofmxdaHyee3X').get();
  //   return isPro ? doc.get('qVersionPro') : doc.get('qVersionFree');
  // }

  //Get question list (either Free or Pro user based on parameter)
  Future<List<Question>?> getQuestionList({required bool isPro}) async {
    debugPrint('/// DB: reading all QUESTION docs... ///');
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
