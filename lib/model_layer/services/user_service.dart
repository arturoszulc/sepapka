import 'package:collection/collection.dart';
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

  getNewQuestionQMap() {
    QMap? qMap;
    if (_loggedUser!.qListNew.isNotEmpty) {
    qMap = _loggedUser!.qListNew.first;
    }
    if (qMap != null) {
      return Success(object: qMap);
    } else {
      return Failure(errorResponse: 'No New question found');
    }
  }

  Future<Object> moveNewQuestionToPractice(String questionId) async {
    //Get QMap by ID from qNewList
    var qMap = getQMapFromNewById(questionId);

    if (qMap != null) {
      var addResult = await addQuestionToPractice(qMap);
      if (addResult is Success) {
        return Success(object: _loggedUser);
      }
    }

    //find Question by ID, retrieve it's QMap, and delete it form list

    //Update QMap

    //Add QMap to Practice List

    return _loggedUser!;
  }

  QMap? getQMapFromNewById(String questionId) {
    //Look it up
    QMap? qMap = _loggedUser!.qListNew
        .firstWhereOrNull((element) => element.id == questionId);
    if (qMap != null) {
      _loggedUser!.qListNew.remove(qMap);
    }
    return qMap;
  }

  addQuestionToPractice(QMap qMap) {
    if (_loggedUser!.qListPractice.contains(qMap)) {
      return Failure(
          errorResponse:
              'addQuestionToPractice() error: Question is already in qListPractice');
    } else {
      _loggedUser!.qListPractice.add(qMap);
      return Success();
    }
  }
}
