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

  moveNewQuestionToPractice(String questionId) async {
    //Get QMap by ID from qNewList
    QMap? qMap = getQMapFromNewById(questionId);

    if (qMap != null) {
      await addQuestionToPractice(qMap);
    }

    //find Question by ID, retrieve it's QMap, and delete it form list

    //Update QMap

    //Add QMap to Practice List
  }

  Future<Object> moveNewQuestionToNew(String questionId) async {
    //Get QMap by ID and delete from qNewList
    QMap? qMap = getQMapFromNewById(questionId);
    if (qMap != null) {
      var addResult = await addQuestionToNew(qMap);
      if (addResult is Success) {
        return Success(object: _loggedUser);
      } else {
        return addResult;
      }
    }
    return _loggedUser!;
  }

  QMap? getQMapFromNewById(String questionId) {
    //Look it up
    QMap? qMap = _loggedUser!.qListNew.firstWhereOrNull((element) => element.id == questionId);
    if (qMap != null) {
      _loggedUser!.qListNew.remove(qMap);
    }
    return qMap;
  }

  addQuestionToPractice(QMap qMap) {
    if (_loggedUser!.qListPractice.contains(qMap)) {
      debugPrint('addQuestionToPractice() error: Question is already in qListPractice');
    } else {
      _loggedUser!.qListPractice.add(qMap);
    }
  }

  addQuestionToNew(QMap qMap) {
    if (_loggedUser!.qListNew.contains(qMap)) {
      return Failure(errorResponse: 'addQuestionToNew() error: Question is already in qListNew');
    } else {
      _loggedUser!.qListNew.add(qMap);
      return Success();
    }
  }
}
