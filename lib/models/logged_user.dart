import 'package:flutter/cupertino.dart';

class LoggedUser extends ChangeNotifier {
  String documentId;
  int qVersion;
  List<Map> qNew;
  List<Map> qUnknown;
  List<Map> qKnown;

  LoggedUser(
      {
        this.documentId = 'defaultId',
        this.qVersion = 0,
        this.qNew = const [],
        this.qUnknown = const [],
        this.qKnown = const []
      });
}
