
import 'package:sepapka/model_layer/models/question_map.dart';

class LoggedUser {
  String documentId;
  int qVersion;
  List<QMap> qListNew;
  List<QMap> qListPractice;
  List<QMap> qListNotShown;

  LoggedUser(
      {
        required this.documentId,
        required this.qVersion,
        required this.qListNew,
        required this.qListPractice,
        required this.qListNotShown
      });
}
