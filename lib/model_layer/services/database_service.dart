import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sepapka/model_layer/models/global_data.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/model_layer/models/remark.dart';
import 'package:sepapka/utils/consts/strings.dart';
import 'package:sepapka/utils/methods.dart';

class DatabaseService {
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('data');
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference remarksCollection = FirebaseFirestore.instance.collection('remarks');
  final CollectionReference purchaseCollection = FirebaseFirestore.instance.collection('purchases');

  // final Query usersRankQuery = FirebaseFirestore.instance
  //     .collection('users')
  //     .orderBy('rankTotalPoints', descending: true)
  //     .limit(10);

  // //UPDATE USER DATA
  // DO NOT USE ASYNC/AWAIT on SET function, because when device is offline, it won't return
  // anything and app will freeze
  Future<void> updateUser(LoggedUser user) {
    debugPrint('/// DB: writing USER doc... ///');
    return usersCollection
        .doc(user.documentId)
        .set({
          // userQVersions: user.qVersions,
          userUsername: user.username,
          userIsPro: user.isPro,
          // userRankLevel: user.rankLevel,
          // userRankTotalPoints: user.rankTotalPoints,
          userQListNew: user.qListNew.map((e) => e.convertToMap()).toList(),
          userQListPractice: user.qListPractice.map((e) => e.convertToMap()).toList(),
          userQListNotShown: user.qListNotShown.map((e) => e.convertToMap()).toList(),
        })
        .then((value) => debugPrint('/// DB: User updated ///'))
        .catchError((error) => debugPrint("DB: Failed to update user: $error"));
  }

  // GET LOGGED USER DATA
  Future<LoggedUser> getUserData(String uid) async {
    debugPrint('/// DB: reading USER doc... ///');
    var doc = await usersCollection.doc(uid).get();
    return LoggedUser(
      documentId: doc.id,
      username: doc.get(userUsername),
      isPro: doc.get(userIsPro),
      // rankLevel: doc.get(userRankLevel),
      // rankTotalPoints: doc.get(userRankTotalPoints),
      // qVersions: List<int>.from(doc.get(userQVersions)),
      qListNew: List<QMap>.from(doc.get(userQListNew).map((e) => convertMapToQMap(e))),
      qListPractice: List<QMap>.from(doc.get(userQListPractice).map((e) => convertMapToQMap(e))),
      qListNotShown: List<QMap>.from(doc.get(userQListNotShown).map((e) => convertMapToQMap(e))),
    );
  }

  // // VERIFY if theres user with the same Username
  // Future<bool> checkIfUsernameIsAvailable(String userId, String username) async {
  //   debugPrint('/// DB: searching for that username... ///');
  //   QuerySnapshot snapshot =
  //       await usersCollection.where('username', isEqualTo: username).get(const GetOptions(source: Source.server));
  //   //if there's no documents with this userName, return True
  //   if (snapshot.docs.isEmpty) return true;
  //   //else username is taken, return FALSE
  //   return false;
  // }

  //Get GlobalData document
  Future<GlobalData> getGlobalData() async {
    debugPrint('/// DB: reading DATA doc... ///');
    var doc = await dataCollection.doc('8zhtbUQgofmxdaHyee3X').get();
    return GlobalData(
      qVersions: List<int>.from(doc.get(globalDataQVersions)),
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
  // Future<List<Question>?> getQuestionList({required int list}) async {
  //   debugPrint('/// DB: reading QList number: $list ///');
  //   QuerySnapshot? snapshot;
  //   switch (list) {
  //     case 1: snapshot = await questions1Collection.get(); break;
  //     case 2: snapshot = await questions2Collection.get(); break;
  //     case 3: snapshot = await questions3Collection.get(); break;
  //     default: snapshot = await questions1Collection.get();
  //   }
  //   return snapshot.docs.map((doc) {
  //     return Question(
  //         id: doc.id,
  //         q: doc.get(questionQ),
  //         a1: doc.get(questionA1),
  //         a2: doc.get(questionA2),
  //         a3: doc.get(questionA3),
  //         a4: doc.get(questionA4),
  //         label: doc.get(questionLabel),
  //         level: doc.get(questionLevel),
  //         assetPath: doc.get(questionAssetPath));
  //   }).toList();
  // }

  //Upload questions to DB ****** method on demand *******
  // Future<void> uploadQuestions({required Question question}) async {
  //   debugPrint('### ID IS ${question.id} ###');
  //
  //   DocumentReference doc;
  //
  //   switch (question.level) {
  //     case 1: doc = questions1Collection.doc(question.id); break;
  //     case 2: doc = questions2Collection.doc(question.id); break;
  //     case 3: doc = questions3Collection.doc(question.id); break;
  //     default: doc = questions1Collection.doc(question.id);
  //   }
  //   return await doc.set({
  //     questionQ: question.q,
  //     questionA1: question.a1,
  //     questionA2: question.a2,
  //     questionA3: question.a3,
  //     questionA4: question.a4,
  //     questionLabel: question.label,
  //     questionLevel: question.level,
  //     questionAssetPath: question.assetPath,
  //   });
  // }

  // List<RankUser> _usersRankTop(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return RankUser(
  //         documentId: doc.id,
  //         username: doc.get(userUsername),
  //         rankLevel: doc.get(userRankLevel),
  //         rankTotalPoints: doc.get(userRankTotalPoints));
  //   }).toList();
  // }

  // List<RankUser>? _usersRankUser(QuerySnapshot snapshot) {
  //   return null;
  //   // return snapshot.docs.map((doc) {
  //   //   return RankUser(
  //   //       documentId: doc.id,
  //   //       username: doc.get(userUsername),
  //   //       rankLevel: doc.get(userRankLevel),
  //   //       rankTotalPoints: doc.get(userRankTotalPoints));
  //   // }).toList();
  // }

  Future<void> sendQuestionRemark(Remark remark) {
    debugPrint('/// DB: writing REMARK doc... ///');
    return remarksCollection
        .doc()
        .set({
          remarkUserId: remark.userId,
          remarkAppVersion: remark.appV,
          remarkDate: remark.date,
          remarkQuestion: remark.question,
          remarkText: remark.text,
        })
        .then((value) => debugPrint('/// DB: Remark sent ///'))
        .catchError((error) => debugPrint("DB: Failed to create remark: $error"));
  }

  Future<String?> verifyPatroniteEmail(String email) async {
    var doc = await dataCollection.doc('8zhtbUQgofmxdaHyee3X').get();
    return List<String>.from(doc.get('patronite')).firstWhereOrNull((e) => e == email);
  }

  Future<void> savePurchaseDetails(EntitlementInfo info, String userID) {
    debugPrint('/// DB: writing PurchaseDetails doc... ///');
    return purchaseCollection
        .doc()
        .set({
          purchaseDocumentCreationDate: DateTime.now().toString(),
          purchaseUserID: userID,
          purchasePurchaseID: info.identifier,
          purchaseProductID: info.productIdentifier,
          purchaseDate: info.latestPurchaseDate,
          purchaseStore: info.store.name,
        })
        .then((value) => debugPrint('/// DB: PurchaseDetails sent ///'))
        .catchError((error) => debugPrint("DB: Error saving PurchaseDetails: $error"));
  }

// Stream<List<RankUser>> get usersRankTop => usersRankQuery.snapshots().map(_usersRankTop);

// Stream<List<RankUser>?> get userRankUser => usersRankQuery.snapshots().map(_usersRankUser);
}
