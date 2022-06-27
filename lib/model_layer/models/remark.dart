import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/consts/strings.dart';

class Remark {

  final String userId;
  final String appV;
  final DateTime date;
  final String question;
  final String text;

  const Remark({
    required this.userId,
    required this.appV,
    required this.date,
    required this.question,
    required this.text,
  });



  factory Remark.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      SnapshotOptions? options) {
    final data = doc.data();
    return Remark(
      userId: data?[remarkConstUserId] ?? '',
      appV: data?[remarkConstAppVersion] ?? '',
      date: data?[remarkConstDate] ?? DateTime.now(),
      question: data?[remarkConstQuestion] ?? '',
      text: data?[appUserConstHiddenQuestionIds] ?? '',
    );
  }

  Map<String,dynamic> toFirestore() {
    return {
      remarkConstUserId: userId,
      remarkConstAppVersion: appV,
      remarkConstDate: date,
      remarkConstQuestion: question,
      remarkConstText: text,
    };
  }

  // Map<String,dynamic> toFirestore() {
  //   return {
  //     appUserConstUsername: username,
  //     appUserConstIsPro: isPro,
  //     appUserConstHiddenQuestionIds: hiddenQuestionIds,
  //   };
  // }

  @override
  toString() {
    return 'userId: $userId, appV: $appV, date: $date, question: $question, text: $text';
  }


}
