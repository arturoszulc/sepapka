
import 'package:sepapka/model_layer/models/question_map.dart';

class LoggedUser {
  String documentId;
  String username;
  bool isPro;
  List qVersions;
  List<QMap> qListNew1;
  List<QMap> qListNew2;
  List<QMap> qListNew3;
  List<QMap> qListPractice;
  List<QMap> qListNotShown;
  int rankLevel;
  int rankTotalPoints;

  LoggedUser(
      {
        required this.documentId,
        required this.username,
        required this.isPro,
        required this.qVersions,
        required this.qListNew1,
        required this.qListNew2,
        required this.qListNew3,
        required this.qListPractice,
        required this.qListNotShown,
        required this.rankLevel,
        required this.rankTotalPoints,
      });
}
