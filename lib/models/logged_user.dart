import 'package:flutter/cupertino.dart';

class LoggedUser extends ChangeNotifier {

  String? documentId;
  int qVersion = 0;
  List<Map> qNew = [];
  List<Map> qUnknown = [];
  List<Map> qKnown= [];


}