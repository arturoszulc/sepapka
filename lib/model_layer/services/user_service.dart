import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/utils/api_status.dart';

class UserService {
  //Models
  LoggedUser? _loggedUser;

  LoggedUser? get loggedUser => _loggedUser;

  createUser(LoggedUser user) {
    _loggedUser = user;
    debugPrint('LoggedUser created: $_loggedUser');
  }

  getKnownQuestionID() {
    debugPrint('UserService.getKnownQuestionID deployed');
    String? qId = _loggedUser!.qListDeleted.first['id'];

    if (qId != null) {
      return Success(response: qId);
    } else {
      return Failure(errorResponse: 'No question found');
    }
  }

  Future<LoggedUser?> moveQuestionToPractice(String questionId) async {

    //find Question by ID, retrieve it's QMap, and delete it form list

    //Update QMap

    //Add QMap to Practice List

      return _loggedUser;

  }

  QMap? getQMapById(String questionId) {
    //Look it up
    return null;
  }

 removeQuestionFromNew(String questionId) {
  if (_loggedUser!.qListNew.contains({'id': questionId})) {
    return true;
  }
}

removeQuestionFromKnown(String questionId) {}

removeQUestionFromUnknown(String questionId) {}
}
