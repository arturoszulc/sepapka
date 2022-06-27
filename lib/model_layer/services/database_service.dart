import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/remark.dart';
import 'package:sepapka/utils/consts/strings.dart';

final databaseService = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

class DatabaseService {
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('data');
  final CollectionReference<AppUser> usersCollection = FirebaseFirestore.instance.collection('users')
      .withConverter(
      fromFirestore: AppUser.fromFirestore,
      toFirestore: (AppUser appUser, _) => appUser.toFirestore(),);
  final CollectionReference<Remark> remarksCollection = FirebaseFirestore.instance.collection('remarks')
  .withConverter(
      fromFirestore: Remark.fromFirestore,
      toFirestore: (Remark remark, _) => remark.toFirestore());
  final CollectionReference purchaseCollection = FirebaseFirestore.instance.collection('purchases');

//artur1111@test.pl id: 9QcFuBrwpHhgSRojxelidsysmnp2

  ///// NEW /////

  Future<AppUser?> getUser(String uid) async {
    debugPrint('/// DB: reading USER doc... ///');
    final doc = await usersCollection.doc(uid).get();
    final user = doc.data();
    if (user != null) {
      return user;
    } else {
      log('/// DB: User not found ///');
      return null;
    }
  }

  //UPDATE USER DATA
  // DO NOT USE ASYNC/AWAIT on SET function, because when device is offline, it won't return
  // anything and app will freeze
  Future<void> updateUser(AppUser user) {
    debugPrint('/// DB: writing USER doc... ///');
    return usersCollection
        .doc(user.id)
        .set(user)
        .then((value) => debugPrint('/// DB: User updated ///'))
        .catchError((error) => debugPrint("DB: Failed to update user: $error"));
  }

  Future<void> sendQuestionRemark(Remark remark) {
    debugPrint('/// DB: writing REMARK doc... ///');
    return remarksCollection
        .doc()
        .set(remark)
        .then((value) => debugPrint('/// DB: Remark sent ///'))
        .catchError((error) => debugPrint("DB: Failed to create remark: $error"));
  }

  Future<void> savePurchaseDetails(EntitlementInfo info, String userID) {
    debugPrint('/// DB: writing PurchaseDetails doc... ///');
    return purchaseCollection
        .doc()
        .set({
      purchaseConstDocumentCreationDate: DateTime.now().toString(),
      purchaseConstUserID: userID,
      purchaseConstPurchaseID: info.identifier,
      purchaseConstProductID: info.productIdentifier,
      purchaseConstDate: info.latestPurchaseDate,
      purchaseConstStore: info.store.name,
    })
        .then((value) => debugPrint('/// DB: PurchaseDetails sent ///'))
        .catchError((error) => debugPrint("DB: Error saving PurchaseDetails: $error"));
  }

  ///// END NEW /////

  // //UPDATE USER DATA
  // DO NOT USE ASYNC/AWAIT on SET function, because when device is offline, it won't return
  // anything and app will freeze
  // Future<void> updateUser(LoggedUser user) {
  //   debugPrint('/// DB: writing USER doc... ///');
  //   return usersCollection
  //       .doc(user.documentId)
  //       .set({
  //         // userQVersions: user.qVersions,
  //         userUsername: user.username,
  //         userIsPro: user.isPro,
  //         userQListNew: user.qListNew.map((e) => e.convertToMap()).toList(),
  //         userQListPractice: user.qListPractice.map((e) => e.convertToMap()).toList(),
  //         userQListNotShown: user.qListNotShown.map((e) => e.convertToMap()).toList(),
  //       })
  //       .then((value) => debugPrint('/// DB: User updated ///'))
  //       .catchError((error) => debugPrint("DB: Failed to update user: $error"));
  // }

  // GET LOGGED USER DATA
  // Future<LoggedUser> getUserData(String uid) async {
  //   debugPrint('/// DB: reading USER doc... ///');
  //   var doc = await usersCollection.doc(uid).get();
  //   return LoggedUser(
  //     documentId: doc.id,
  //     username: doc.get(userUsername),
  //     isPro: doc.get(userIsPro),
  //     // rankLevel: doc.get(userRankLevel),
  //     // rankTotalPoints: doc.get(userRankTotalPoints),
  //     // qVersions: List<int>.from(doc.get(userQVersions)),
  //     qListNew: List<QMap>.from(doc.get(userQListNew).map((e) => convertMapToQMap(e))),
  //     qListPractice: List<QMap>.from(doc.get(userQListPractice).map((e) => convertMapToQMap(e))),
  //     qListNotShown: List<QMap>.from(doc.get(userQListNotShown).map((e) => convertMapToQMap(e))),
  //   );
  // }

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
  // Future<GlobalData> getGlobalData() async {
  //   debugPrint('/// DB: reading DATA doc... ///');
  //   var doc = await dataCollection.doc('8zhtbUQgofmxdaHyee3X').get();
  //   return GlobalData(
  //     qVersions: List<int>.from(doc.get(globalDataQVersions)),
  //     rankNames: List<String>.from(doc.get(globalDataRankNames)),
  //     rankThresholds: List<int>.from(doc.get(globalDataRankThresholds)),
  //   );
  // }




  Future<String?> verifyPatroniteEmail(String email) async {
    var doc = await dataCollection.doc('8zhtbUQgofmxdaHyee3X').get();
    return List<String>.from(doc.get('patronite')).firstWhereOrNull((e) => e == email);
  }



}
