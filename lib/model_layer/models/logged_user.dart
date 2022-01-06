
import 'package:sepapka/model_layer/models/question_map.dart';

class LoggedUser {
  String documentId;
  int qListVersion;
  List<QMap> qListNew;
  List<QMap> qListPractice;
  List<QMap> qListDeleted;

  LoggedUser(
      {
        required this.documentId,
        required this.qListVersion,
        required this.qListNew,
        required this.qListPractice,
        required this.qListDeleted
      });
}
