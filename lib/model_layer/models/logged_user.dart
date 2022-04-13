
import 'package:sepapka/model_layer/models/question_map.dart';

class LoggedUser {
  String documentId;
  String username;
  bool isPro;
  List qVersions;
  List<QMap> qListNew;
  List<QMap> qListPractice; //not used
  List<QMap> qListNotShown;
  int rankLevel;
  int rankTotalPoints;

  LoggedUser(
      {
        required this.documentId,
        required this.username,
        required this.isPro,
        required this.qVersions,
        required this.qListNew,
        required this.qListPractice,
        required this.qListNotShown,
        required this.rankLevel,
        required this.rankTotalPoints,
      });
}
