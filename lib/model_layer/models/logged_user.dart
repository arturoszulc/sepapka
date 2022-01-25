
import 'package:sepapka/model_layer/models/question_map.dart';

class LoggedUser {
  String documentId;
  bool isPro;
  int qVersion;
  List<QMap> qListNew1;
  List<QMap> qListNew2;
  List<QMap> qListNew3;
  List<QMap> qListPractice;
  List<QMap> qListNotShown;

  LoggedUser(
      {
        required this.documentId,
        required this.isPro,
        required this.qVersion,
        required this.qListNew1,
        required this.qListNew2,
        required this.qListNew3,
        required this.qListPractice,
        required this.qListNotShown
      });
}
