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
  final DateTime _today = DateTime.parse(DateTime.now().toString().substring(0,10));

  //Models
  LoggedUser? _loggedUser;


  bool get loggedUserChanged => _loggedUserChanged;

  LoggedUser? get loggedUser => _loggedUser;

  double getProgressPercent() {
    int allQuestions = _loggedUser!.qListNew.length +
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
    else if (userId != null) {
      _loggedUser = LoggedUser(
          documentId: userId,
          qVersion: 0,
          qListNew: [],
          qListPractice: [],
          qListNotShown: []);
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

  Future<void> updateQNewList(List<Question> qListGlobal) async {
    for (var question in qListGlobal) {
      //check if question is on any list
      bool isOnAnyList = isQuestionInAnyList(question.id);

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

  bool isQuestionInAnyList(String questionId) {
    return isQuestionInNewList(questionId) != null ||
        isQuestionInPracticeList(questionId) != null ||
        isQuestionInNotShownList(questionId) != null;
  }

  QMap? isQuestionInNewList(String questionId) {
    return _loggedUser!.qListNew.firstWhereOrNull((qMap) => qMap.id == questionId);
  }

  QMap? isQuestionInPracticeList(String questionId) {
    return _loggedUser!.qListPractice.firstWhereOrNull((qMap) => qMap.id == questionId);
  }

  QMap? isQuestionInNotShownList(String questionId) {
    return _loggedUser!.qListNotShown.firstWhereOrNull((qMap) => qMap.id == questionId);
  }

  // removeQuestionFromList({required QuestionType qType, required String questionId}) {
  //   if (qType == QuestionType.newQuestion) {
  //     int index = _loggedUser!.qListNew.indexWhere((qMap) => qMap.id == questionId);
  //     if (index >= 0) _loggedUser!.qListNew.removeAt(index);
  //   }
  //   if (qType == QuestionType.practiceQuestion) {
  //     int index = _loggedUser!.qListPractice.indexWhere((qMap) => qMap.id == questionId);
  //     if (index >= 0) _loggedUser!.qListPractice.removeAt(index);
  //   }
  // }


  removeQuestionFromAnyMap(String questionId) {
    _loggedUser!.qListNew.removeWhere((e) => e.id == questionId);
    _loggedUser!.qListPractice.removeWhere((e) => e.id == questionId);
    _loggedUser!.qListNotShown.removeWhere((e) => e.id == questionId);
  }

  QMap createQMapForNewQuestion(String? qId) {
    return QMap(id: qId, dateModified: DateTime.now().toString().substring(0, 10), fibNum: 0);
  }

  QMap? getNewQMapById(String questionId) {
    return _loggedUser!.qListNew.firstWhereOrNull((element) => element.id == questionId);
  }

  List<QMap> getTodayPracticeQMapList() {
    List<QMap> todayPracticeList = [];

    if (_loggedUser!.qListPractice.isNotEmpty) {
      for (var qMap in _loggedUser!.qListPractice) {
        debugPrint('Checking practice question');
        if (getDateDifferenceInDays(qMap) < 1) {
          todayPracticeList.add(qMap);
        }
      }
    }
    return todayPracticeList;
  }


  moveNewQuestionToNew(String questionId) async {
    //Get QMap by ID and delete from qNewList
    QMap? qMap = getQMapFromNewById(questionId);
    if (qMap != null) {
      var addResult = await addQuestionToNew(qMap);
    }
  }

  moveNewQuestionToPractice(String questionId) async {
    //Get QMap by ID from qNewList
    QMap? qMap = getQMapFromNewById(questionId);

    //updateQMap with new Date and FibNum
    if (qMap != null) {
      qMap.dateModified = _today.toString().substring(0, 10);
      qMap.fibNum = getNextFibNum(qMap.fibNum);

      //add question QMap to Practice list
      await addQuestionToPractice(qMap);
    }
  }

  movePracticeQuestionToPractice({required String questionId, required bool update}) async {
    //Get QMap by ID from qPracticeList
    QMap? qMap = getQMapFromPracticeById(questionId);

    if (qMap != null) {
      if (update){
        //updateQMap with new Date and FibNum
        qMap.dateModified = _today.toString().substring(0, 10);
        qMap.fibNum = getNextFibNum(qMap.fibNum);
      }
      //add question QMap to Practice list
      await addQuestionToPractice(qMap);
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

  QMap? getQMapFromPracticeById(String questionId) {
    //Look it up
    QMap? qMap = _loggedUser!.qListPractice.firstWhereOrNull((element) => element.id == questionId);
    if (qMap != null) {
      _loggedUser!.qListPractice.remove(qMap);
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

  cleanUserQLists() {
    _loggedUser!.qListNew.clear();
    _loggedUser!.qListPractice.clear();
    _loggedUser!.qListNotShown.clear();
  }


  getDateDifferenceInDays(QMap question) {
    DateTime parsedDate = DateTime.parse(question.dateModified);
    DateTime whenToPractice = parsedDate.add(Duration(days: question.fibNum));
    //delete this var temp and just return it
    var temp = whenToPractice
        .difference(_today)
        .inDays;
    debugPrint(temp.toString());
    return temp;
  }

  getNextFibNum(int currentFibNum) {
    int currentFibNumIndex = fibSeries.indexOf(currentFibNum);
    return fibSeries[currentFibNumIndex + 1];
  }
}
