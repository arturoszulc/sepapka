
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sepapka/model_layer/models/question_map.dart';

import '../../utils/consts/strings.dart';


class AppUser {
  final String id;
  final String username;
  final bool isPro;
  final List<String> hiddenQuestionIds;

  const AppUser({
    required this.id,
    required this.username,
    required this.isPro,
    required this.hiddenQuestionIds,
  });

  factory AppUser.empty() {
    return const AppUser(
        id: '',
        username: '',
        isPro: false,
        hiddenQuestionIds: []);
  }

  factory AppUser.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      SnapshotOptions? options) {
    final data = doc.data();
    return AppUser(
      id: doc.id,
      username: data?[appUserConstUsername] ?? '',
      isPro: data?[appUserConstIsPro] ?? false,
      hiddenQuestionIds: List<String>.from(data?[appUserConstHiddenQuestionIds]),
    );
  }

  Map<String,dynamic> toFirestore() {
    return {
      appUserConstUsername: username,
      appUserConstIsPro: isPro,
      appUserConstHiddenQuestionIds: hiddenQuestionIds,
    };
  }



  AppUser copyWith({
    String? id,
    String? username,
    bool? isPro,
    List<String>? hiddenQuestionIds,
  }) {
    return AppUser(
      id: id ?? this.id,
      username: username ?? this.username,
      isPro: isPro ?? this.isPro,
      hiddenQuestionIds: hiddenQuestionIds ?? this.hiddenQuestionIds,
    );
  }

  @override
  toString() {
    return 'id: $id, username: $username, isPro: $isPro, hiddenQuestionIds: $hiddenQuestionIds';
  }
}

class LoggedUser {
  String documentId;
  String username;
  bool isPro;
  // List qVersions;
  List<QMap> qListNew;
  List<QMap> qListPractice; //not used
  List<QMap> qListNotShown;
  // int rankLevel;
  // int rankTotalPoints;

  LoggedUser(
      {
        required this.documentId,
        required this.username,
        required this.isPro,
        // required this.qVersions,
        required this.qListNew,
        required this.qListPractice,
        required this.qListNotShown,
        // required this.rankLevel,
        // required this.rankTotalPoints,
      });

}
