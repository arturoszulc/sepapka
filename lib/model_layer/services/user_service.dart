import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts.dart';

import '../../locator.dart';
import '../models/question.dart';
import 'database_service.dart';

class UserService {
  //Services injection
  final DatabaseService _databaseService = serviceLocator.get<DatabaseService>();

  //Properties
  bool _loggedUserChanged = false;

  //parsing subString to get rid of time
  final DateTime _today = DateTime.parse(DateTime.now().toString().substring(0, 10));

  //Models
  LoggedUser? _loggedUser;

  bool get loggedUserChanged => _loggedUserChanged;

  LoggedUser? get loggedUser => _loggedUser;

  double getProgressPercent() {
    int allQuestions = _loggedUser!.qListNew1.length +
        _loggedUser!.qListNew2.length +
        _loggedUser!.qListNew3.length +
        _loggedUser!.qListPractice.length +
        _loggedUser!.qListNotShown.length;

    int knownQuestions = _loggedUser!.qListPractice.length;
    double progress = knownQuestions / allQuestions;
    double number = num.parse(progress.toStringAsFixed(2)).toDouble();

    return number;
  }

  createDefaultLoggedUser(String userId) async {
    _loggedUser = LoggedUser(
        documentId: userId,
        isPro: false,
        qVersion: 0,
        qListNew1: [],
        qListNew2: [],
        qListNew3: [],
        qListPractice: [],
        qListNotShown: []);
  }

  setLoggedUserChanged(bool status) {
    _loggedUserChanged = status;
  }

  Future<Object> createUserLocal(String userId) async {
    try {
      _loggedUser = await _databaseService.getUserData(userId);
      return Success();
    } catch (e) {
      debugPrint(errorGetUserDataFromDB);
      //if there's an error, assume that user was not yet created
      createDefaultLoggedUser(userId);
      return Success();
    }
  }

  logOutUser() {
    _loggedUser = null;
  }

  bool compareQVersion(int qVersion) {
    if (qVersion == loggedUser!.qVersion) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateQNewLists(List<Question> qListGlobal) async {
    for (var question in qListGlobal) {
      //check if question is on any list
      bool isOnAnyList = isQuestionInAnyList(question.id);

      if (!isOnAnyList) {
        //jeśli nie, stwórz jego mapę i zapisz do qNewList
        QMap qMap = createDefaultQMap(question.id);
        addQuestionToNew(qMap, question.level);
        //set flag, that user object was changed

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

  bool isQuestionInAnyList(String questionId) {
    return isQuestionInNew1(questionId) != null ||
        isQuestionInNew2(questionId) != null ||
        isQuestionInNew3(questionId) != null ||
        isQuestionInPracticeList(questionId) != null ||
        isQuestionInNotShownList(questionId) != null;
  }

  QMap? isQuestionInNew1(String questionId) {
    return _loggedUser!.qListNew1.firstWhereOrNull((qMap) => qMap.id == questionId);
  }

  QMap? isQuestionInNew2(String questionId) {
    return _loggedUser!.qListNew2.firstWhereOrNull((qMap) => qMap.id == questionId);
  }

  QMap? isQuestionInNew3(String questionId) {
    return _loggedUser!.qListNew3.firstWhereOrNull((qMap) => qMap.id == questionId);
  }

  QMap? isQuestionInPracticeList(String questionId) {
    return _loggedUser!.qListPractice.firstWhereOrNull((qMap) => qMap.id == questionId);
  }

  QMap? isQuestionInNotShownList(String questionId) {
    return _loggedUser!.qListNotShown.firstWhereOrNull((qMap) => qMap.id == questionId);
  }

  removeQuestionFromAnyMap(String questionId) {
    _loggedUser!.qListNew1.removeWhere((e) => e.id == questionId);
    _loggedUser!.qListNew2.removeWhere((e) => e.id == questionId);
    _loggedUser!.qListNew3.removeWhere((e) => e.id == questionId);
    _loggedUser!.qListPractice.removeWhere((e) => e.id == questionId);
    _loggedUser!.qListNotShown.removeWhere((e) => e.id == questionId);
  }

  QMap createDefaultQMap(String? qId) {
    return QMap(id: qId, dateModified: DateTime.now().toString().substring(0, 10), fibNum: 0);
  }

  List<QMap> getQMapNewList(int qLevel) {
    switch (qLevel) {
      case 1:
        return _loggedUser!.qListNew1;
      case 2:
        return _loggedUser!.qListNew2;
      case 3:
        return _loggedUser!.qListNew3;
    }
    return [];
  }

  List<QMap> getTodayPracticeQMapList() {
    debugPrint('/// getTodayPracticeQMapList deployed ///');
    List<QMap> todayPracticeList = [];

    if (_loggedUser!.qListPractice.isNotEmpty) {
      for (var qMap in _loggedUser!.qListPractice) {
        if (getDateDifferenceInDays(qMap) < 1) {
          todayPracticeList.add(qMap);
        }
      }
    }
    return todayPracticeList;
  }

  moveQuestionToNew(String qId, QuestionType qType, int qLevel) async {
    //Get QMap
    QMap? qMap = getQMapAndRemove(qId, qType, qLevel);
    if (qMap != null) {
      await addQuestionToNew(qMap, qLevel);
    }
    if (_loggedUserChanged) {
      await _databaseService.updateUser(_loggedUser!);
      setLoggedUserChanged(false);
    }
  }

  moveQuestionToPractice(String qId, QuestionType qType, int qLevel, bool update) async {
    debugPrint('/// moveQuestionToPractice deployed ///');
    //Get QMap by ID from qNewList
    QMap? qMap = getQMapAndRemove(qId, qType, qLevel);

    if (qMap != null) {
      //if update, set new Date and FibNum
      if (update) {
        qMap.dateModified = _today.toString().substring(0, 10);
        qMap.fibNum = getNextFibNum(qMap.fibNum);
        setLoggedUserChanged(true);
      }
      //add question QMap to Practice list
      await addQuestionToPractice(qMap);

      if (_loggedUserChanged) {
        await _databaseService.updateUser(_loggedUser!);
        setLoggedUserChanged(false);
      }
    }
  }

  // movePracticeQuestionToPractice({required String questionId, required bool update}) async {
  //   //Get QMap by ID from qPracticeList
  //   QMap? qMap = getQMapFromPracticeById(questionId);
  //
  //   if (qMap != null) {
  //     if (update) {
  //       //updateQMap with new Date and FibNum
  //       qMap.dateModified = _today.toString().substring(0, 10);
  //       qMap.fibNum = getNextFibNum(qMap.fibNum);
  //     }
  //     //add question QMap to Practice list
  //     await addQuestionToPractice(qMap);
  //   }
  // }

  QMap? getQMapAndRemove(String qId, QuestionType qType, int qLevel) {
    QMap? qMap;
    //method cuts out qMap from it's list and returns it
    switch (qType) {
      case QuestionType.newQuestion:
        switch (qLevel) {
          case 1:
            qMap = _loggedUser!.qListNew1.firstWhereOrNull((element) => element.id == qId);
            _loggedUser!.qListNew1.remove(qMap);
            return qMap;
          case 2:
            qMap = _loggedUser!.qListNew2.firstWhereOrNull((element) => element.id == qId);
            _loggedUser!.qListNew2.remove(qMap);
            return qMap;

          case 3:
            qMap = _loggedUser!.qListNew3.firstWhereOrNull((element) => element.id == qId);
            _loggedUser!.qListNew3.remove(qMap);
            return qMap;
        }
        break;
      case QuestionType.practiceQuestion:
        qMap = _loggedUser!.qListPractice.firstWhereOrNull((element) => element.id == qId);
        _loggedUser!.qListPractice.remove(qMap);
        return qMap;
    }
  }

  addQuestionToNew(QMap qMap, int qLevel) {
    //Before this method, it is checked if qMap is on any map.
    //So there's no need to check it again
    setLoggedUserChanged(true);
    switch (qLevel) {
      case 1:
        _loggedUser!.qListNew1.add(qMap);
        break;
      case 2:
        _loggedUser!.qListNew2.add(qMap);
        break;
      case 3:
        _loggedUser!.qListNew3.add(qMap);
        break;
    }
  }

  addQuestionToPractice(QMap qMap) {

    _loggedUser!.qListPractice.add(qMap);
  }

  addQuestionToNotShown(QMap qMap) {}

  cleanUserQLists() {
    _loggedUser!.qListNew1.clear();
    _loggedUser!.qListNew2.clear();
    _loggedUser!.qListNew3.clear();
    _loggedUser!.qListPractice.clear();
    _loggedUser!.qListNotShown.clear();
  }

  getDateDifferenceInDays(QMap question) {
    DateTime parsedDate = DateTime.parse(question.dateModified);
    DateTime whenToPractice = parsedDate.add(Duration(days: question.fibNum));
    return whenToPractice.difference(_today).inDays;
  }

  getNextFibNum(int currentFibNum) {
    int currentFibNumIndex = fibSeries.indexOf(currentFibNum);
    return fibSeries[currentFibNumIndex + 1];
  }
}
