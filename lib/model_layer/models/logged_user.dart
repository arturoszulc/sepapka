
import 'package:sepapka/model_layer/models/question_map.dart';

class LoggedUser {
  String documentId;
  int qVersion;
  List<QMap> qNew;
  List<QMap> qUnknown;
  List<QMap> qKnown;

  LoggedUser(
      {
        required this.documentId,
        required this.qVersion,
        required this.qNew,
        required this.qUnknown,
        required this.qKnown
      });
}
