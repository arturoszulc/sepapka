import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/utils/api_status.dart';

class UserService {
  //Models
  LoggedUser? _loggedUser;

  LoggedUser? getUser() {
    return _loggedUser;
  }

  createUser(LoggedUser user) {
    _loggedUser = user;
    debugPrint('LoggedUser created: $_loggedUser');
  }

  getKnownQuestionID() {
    debugPrint('UserService.getKnownQuestionID deployed');
    String? qId = _loggedUser!.qKnown.first['id'];

    if (qId != null) {
      return Success(response: qId);
    } else {
      return Failure(errorResponse: 'No question found');
    }
  }

  Future<LoggedUser?> addQuestionToKnown(String questionId) async {
    var removeNewResult = await removeQuestionFromNew(questionId);
    var removeKnownResult = await removeQuestionFromKnown(questionId);
    var removeUnknownResult = await removeQUestionFromUnknown(questionId);
    if (removeNewResult || removeUnknownResult) {
      return getUser();
    }
    else {
      return null;
    }
  }

 removeQuestionFromNew(String questionId) {
  if (_loggedUser!.qNew.contains({'id': questionId})) {
    return true;
  }
}

removeQuestionFromKnown(String questionId) {}

removeQUestionFromUnknown(String questionId) {}
}
