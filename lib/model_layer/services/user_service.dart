import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';

// import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts/errors_messages.dart';
import 'package:sepapka/utils/consts/question.dart';
import 'package:sepapka/utils/methods.dart';

import '../../locator.dart';
import '../models/question.dart';
import 'database_service.dart';

class UserService {
  //Services injection
  final DatabaseService _databaseService = serviceLocator.get<DatabaseService>();

  //Properties
  bool _loggedUserChanged = false;
  bool _isUserPromoted = false;
  List<String> _rankNames = [];
  List<int> _rankThresholds = [];

  //parsing subString to get rid of time
  final DateTime _today = DateTime.parse(DateTime.now().toString().substring(0, 10));

  //Models
  LoggedUser? _loggedUser;

  //Getters
  LoggedUser? get loggedUser => _loggedUser;

  bool get loggedUserChanged => _loggedUserChanged;

  bool get isUserPromoted => _isUserPromoted;

  String get userRankName => _rankNames[_loggedUser!.rankLevel];

  // StreamController<LoggedUser?> loggedUserStreamController = StreamController();
  //Streams
  // Stream<LoggedUser?> get loggedUserStream => loggedUserStreamController.stream;

  setIsUserPromoted(bool flag) {
    _isUserPromoted = flag;
  }

  String getProgressPercentGlobal() {
    int previousThreshold = 0;
    int currentThreshold = _rankThresholds[_loggedUser!.rankLevel];
    if (_loggedUser!.rankLevel > 0) {
      previousThreshold = _rankThresholds[_loggedUser!.rankLevel - 1];
    }
    double progressInt =
        (_loggedUser!.rankTotalPoints - previousThreshold) * 100 / currentThreshold;
    String progressDouble = progressInt.toStringAsFixed(1);

    return progressDouble;
  }

  addPoints(int points) {
    //add points
    _loggedUser!.rankTotalPoints += points;
    //calculate rank
    if (_loggedUser!.rankTotalPoints >= _rankThresholds[_loggedUser!.rankLevel]) {
      _loggedUser!.rankLevel += 1;
      setIsUserPromoted(true);
    }
  }

  createDefaultLoggedUser(String userId) async {
    _loggedUser = LoggedUser(
        documentId: userId,
        username: 'uczeń-' + getRandomString(5),
        isPro: false,
        rankLevel: 0,
        rankTotalPoints: 0,
        qVersion: 0,
        qListNew1: [],
        qListNew2: [],
        qListNew3: [],
        qListPractice: [],
        qListNotShown: []);
  }

  setLoggedUserChanged(bool status) {
    //some flag to keep track if user has changed (helpful in some loops)
    _loggedUserChanged = status;
  }

  Future<Object> createUserLocal(String userId) async {
    try {
      _loggedUser = await _databaseService.getUserData(userId);
      // loggedUserStreamController.add(_loggedUser);
      return Success();
    } catch (e) {
      debugPrint(errorGetUserDataFromDB);
      //if there's an error, assume that user was not yet created
      createDefaultLoggedUser(userId);
      // loggedUserStreamController.add(_loggedUser);
      return Success();
    }
  }

  Future<Object> rollUserBack() async {
    try {
      _loggedUser = await _databaseService.getUserData(_loggedUser!.documentId);
      return Success();
    } catch (e) {
      debugPrint(errorRollBackUser);
      return Failure(errorRollBackUser);
    }
  }

  Future<Object> updateLoggedUserInDb() async {
    try {
      await _databaseService.updateUser(_loggedUser!);
      return Success();
    } catch (e) {
      debugPrint(errorUpdateUserInDb);
      return Failure(errorUpdateUserInDb);
    }
  }

  logOutUser() {
    _loggedUser = null;
    // loggedUserStreamController.add(_loggedUser);
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
        addQMapToNew(qMap, question.level);
        //set flag, that user object was changed

      }
    }
    //if loggedUser changed, update it on DB at the end
    if (_loggedUserChanged) {
      await _databaseService.updateUser(_loggedUser!);
      setLoggedUserChanged(false);
    }
  }

  prepareRanks(List<String> rankNames, List<int> rankThresholds) {
    debugPrint('/// Preparing ranks data... ///');
    _rankNames = rankNames;
    _rankThresholds = rankThresholds;
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

  removeQuestionFromAnyQList(String questionId) {
    _loggedUser!.qListNew1.removeWhere((e) => e.id == questionId);
    _loggedUser!.qListNew2.removeWhere((e) => e.id == questionId);
    _loggedUser!.qListNew3.removeWhere((e) => e.id == questionId);
    _loggedUser!.qListPractice.removeWhere((e) => e.id == questionId);
    _loggedUser!.qListNotShown.removeWhere((e) => e.id == questionId);
  }

  QMap createDefaultQMap(String? qId) {
    return QMap(id: qId, dateModified: DateTime.now().toString().substring(0, 10), fibNum: 0);
  }

  List<QMap> getQMapsFromNewList(int qLevel) {
    //return only first 10 elements
    switch (qLevel) {
      case 1:
        return _loggedUser!.qListNew1.slice(0, min(9, _loggedUser!.qListNew1.length));
      case 2:
        return _loggedUser!.qListNew2.slice(0, min(9, _loggedUser!.qListNew2.length));

      case 3:
        return _loggedUser!.qListNew3.slice(0, min(9, _loggedUser!.qListNew3.length));
    }
    return [];
  }

  List<QMap> getTodayPracticeQMapList() {
    debugPrint('/// UserService: Getting TodayPracticeQMapList... ///');
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

  // moveQuestionToNew(String qId, QuestionType qType, int qLevel) async {
  //   //Get QMap
  //   QMap? qMap = getQMapAndRemove(qId, qType, qLevel);
  //   if (qMap != null) {
  //     await addQuestionToNew(qMap, qLevel);
  //   }
  //   if (_loggedUserChanged) {
  //     await _databaseService.updateUser(_loggedUser!);
  //     setLoggedUserChanged(false);
  //   }
  // }

  moveQMapToPractice(String qId, QuestionType qType, int qLevel, bool update) async {
    debugPrint('/// Moving QMap to practice list... ///');
    //Get QMap by ID from qNewList
    QMap? qMap = getQMapAndRemove(qId, qType, qLevel);

    if (qMap != null) {
      //if update, set new Date and FibNum
      if (update) {
        qMap.dateModified = _today.toString().substring(0, 10);
        qMap.fibNum = getNextFibNum(qMap.fibNum);
        // setLoggedUserChanged(true);
      }
      //add question QMap to Practice list
      await addQMapToPractice(qMap);
    }
  }

  moveQMapToNotShown(String qId, QuestionType qType, int qLevel) async {
    //Get QMap by ID from qNewList
    QMap? qMap = getQMapAndRemove(qId, qType, qLevel);
    if (qMap != null) {
      await addQMapToNotShown(qMap);
      debugPrint('/// US: Moved QMap to NotShow list ///');
    }
  }

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

  addQMapToNew(QMap qMap, int qLevel) {
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

  addQMapToPractice(QMap qMap) {
    _loggedUser!.qListPractice.add(qMap);
  }

  addQMapToNotShown(QMap qMap) {
    _loggedUser!.qListNotShown.add(qMap);
  }

  wipeUser() {
    _loggedUser!.rankLevel = 0;
    _loggedUser!.rankTotalPoints = 0;
    _loggedUser!.qListNew1.clear();
    _loggedUser!.qListNew2.clear();
    _loggedUser!.qListNew3.clear();
    _loggedUser!.qListPractice.clear();
    _loggedUser!.qListNotShown.clear();
  }

  //bool property of this method is to be deleted - it will only allow to go PRO
  Future<Object> goPro(bool bool) async {
    if (!bool) wipeUser(); //if go FREE, wipe user
    _loggedUser!.isPro = bool;
    _loggedUser!.qVersion = 1;
    try {
      await _databaseService.updateUser(_loggedUser!);
      return Success();
    } catch (e) {
      debugPrint(e.toString());
      return Failure(errorUpdateUserInDb);
    }
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

  Future<Object> changeUserName(String username) async {
    //check if name was even changed
    if (username == _loggedUser!.username) return Success();

    //validate characters
    Object validateResult = validateUsername(username);
    if (validateResult is Failure) return validateResult;

    //check if username is not taken
    try {
      bool isUsernameAvailableResult =
          await _databaseService.checkIfUsernameIsAvailable(_loggedUser!.documentId, username);
      if (!isUsernameAvailableResult) return Failure(usernameTakenError);
      //if TRUE, update user on DB
      _loggedUser!.username = username;
      await _databaseService.updateUser(_loggedUser!);

      //return Success
      return Success();
    } catch (e) {
      debugPrint(e.toString());
      return Failure(errorDbGeneric);
    }
  }

  Widget getQListIcon(String qId) {
    if (isQuestionInPracticeList(qId) != null) {
      return qListIcons['practice']!;
    }
    if (isQuestionInNotShownList(qId) != null) {
      return qListIcons['notShown']!;
    } else {
      return qListIcons['new']!;
    }
  }
}
