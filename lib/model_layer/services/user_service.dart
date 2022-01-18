import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/utils/api_status.dart';

import '../../locator.dart';
import '../models/question.dart';
import 'database_service.dart';

class UserService {

  //Services injection
  DatabaseService _databaseService = serviceLocator.get<DatabaseService>();

  //Properties
  bool _loggedUserChanged = false;
  int _progressPercent = 0;

  //Models
  LoggedUser? _loggedUser;

  bool get loggedUserChanged => _loggedUserChanged;
  LoggedUser? get loggedUser => _loggedUser;


  double getProgressPercent() {
    int allQuestions =
        _loggedUser!.qListNew.length +
        _loggedUser!.qListPractice.length +
        _loggedUser!.qListNotShown.length;

    int knownQuestions = _loggedUser!.qListPractice.length;
    double progress = knownQuestions / allQuestions;
    double number = num.parse(progress.toStringAsFixed(2)).toDouble();

    return number;
  }

  setLoggedUserChanged(bool status) {
    _loggedUserChanged = status;
  }

  createUserLocal({LoggedUser? user, String? userId}) {
    //if user data is fetched, update user
    if (user != null) {
      _loggedUser = user;
    }
    //if only userId is fetched, create basic user
    else if (userId != null)
      {
        _loggedUser = LoggedUser(
            documentId: userId,
            qVersion: 0,
            qListNew: [],
            qListPractice: [],
            qListNotShown: []
        );
      }


  }


  logOutUser() {
    _loggedUser = null;
  }

  compareQVersion(int qVersion) {
      if (qVersion == loggedUser!.qVersion) {
        return true;
      } else {
        return false;
      }
  }
  Future<void> updateQNewList(List<Question> qListGlobal) async {
    for (var question in qListGlobal) {
    //check if question is on any list
    bool isOnAnyList = isQuestionOnAnyLoggedUserList(question.id);

    if (!isOnAnyList) {
      //jeśli nie, stwórz jego mapę i zapisz do qNewList
      QMap qMap = createQMapForNewQuestion(question.id);
      addQuestionToNew(qMap);
      //set flag, that user object was changed
      setLoggedUserChanged(true);
    }
    }
    //if loggedUser changed, update it on DB at the end
    if (_loggedUserChanged) {
      await _databaseService.updateUser(_loggedUser!);
      setLoggedUserChanged(false);
    }
  }

  updateQVersion(int qVersion) {
    _loggedUser!.qVersion = qVersion;
  }

  bool isQuestionOnAnyLoggedUserList(String? questionId) {
    QMap? qMap;
    //check in qNewList
    qMap ??= _loggedUser!.qListNew.firstWhereOrNull((element) => element.id == questionId);
    qMap ??= _loggedUser!.qListPractice.firstWhereOrNull((element) => element.id == questionId);
    qMap ??= _loggedUser!.qListNotShown.firstWhereOrNull((element) => element.id == questionId);

    if (qMap != null) {
      return true;
    }
    else {
    return false;
  }
  }
  QMap createQMapForNewQuestion(String? qId) {
    return QMap(
        id: qId,
        dateModified: DateTime.now().toString(),
        numberFib: 0);
  }

  QMap? getNewQuestionQMap() {
    QMap? qMap;
    if (_loggedUser!.qListNew.isNotEmpty) {
      qMap = _loggedUser!.qListNew.first;
    }
    if (qMap == null) {
      debugPrint('/// No new questions available ///');
    }
    return qMap;
  }

  QMap? getPracticeQuestionQMap() {
    QMap? qMap;
    if (_loggedUser!.qListPractice.isNotEmpty) {
      qMap = _loggedUser!.qListPractice.first;
    }
    if (qMap == null) {
      debugPrint('getPracticeQuestionQMap error: No practice questions');
    }
    return qMap;
  }

  moveNewQuestionToPractice(String questionId) async {
    //Get QMap by ID from qNewList
    QMap? qMap = getQMapFromNewById(questionId);

    if (qMap != null) {
      await addQuestionToPractice(qMap);
    }

  }

  moveNewQuestionToNew(String questionId) async {
    //Get QMap by ID and delete from qNewList
    QMap? qMap = getQMapFromNewById(questionId);
    if (qMap != null) {
      var addResult = await addQuestionToNew(qMap);
    }

  }

  QMap? getQMapFromNewById(String questionId) {
    //Look it up
    QMap? qMap = _loggedUser!.qListNew.firstWhereOrNull((element) => element.id == questionId);
    if (qMap != null) {
      _loggedUser!.qListNew.remove(qMap);
    }
    return qMap;
  }

  addQuestionToPractice(QMap qMap) async {
    if (_loggedUser!.qListPractice.contains(qMap)) {
      debugPrint('addQuestionToPractice() error: Question is already in qListPractice');
    } else {
      _loggedUser!.qListPractice.add(qMap);
      await _databaseService.updateUser(_loggedUser!);
    }
  }

  addQuestionToNew(QMap qMap) {
    if (_loggedUser!.qListNew.contains(qMap)) {
      return Failure('addQuestionToNew() error: Question is already in qListNew');
    } else {
      _loggedUser!.qListNew.add(qMap);
      return Success();
    }
  }
}
