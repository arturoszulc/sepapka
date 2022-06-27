import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts/errors_messages.dart';
import 'package:sepapka/viewmodel_layer/app_state_controller.dart';
import 'database_service.dart';


// final appUserProvider = StateProvider<AppUser>((ref) => AppUser.empty());

final userService = StateNotifierProvider<UserService, AppUser>((ref) => UserService(ref)
);

class UserService extends StateNotifier<AppUser> {
  UserService(this._ref) : super(AppUser.empty());

  final Ref _ref;

  //Models
  LoggedUser? _loggedUser;

  //Getters
  LoggedUser? get loggedUser => _loggedUser;

  // bool get loggedUserChanged => _loggedUserChanged;

  // bool get userLeveledUp => _userLeveledUp;

  // String get userRankName => _rankNames[_loggedUser!.rankLevel];

  // StreamController<LoggedUser?> loggedUserStreamController = StreamController();
  //Streams
  // Stream<LoggedUser?> get loggedUserStream => loggedUserStreamController.stream;

  // setUserLeveledUp(bool flag) {
  //   _userLeveledUp = flag;
  // }

  // String getProgressPercentGlobal() {
  //   int previousThreshold = 0;
  //   int currentThreshold = _rankThresholds[_loggedUser!.rankLevel];
  //   if (_loggedUser!.rankLevel > 0) {
  //     previousThreshold = _rankThresholds[_loggedUser!.rankLevel - 1];
  //   }
  //   double progressInt =
  //       (_loggedUser!.rankTotalPoints - previousThreshold) * 100 / currentThreshold;
  //   String progressDouble = progressInt.toStringAsFixed(1);
  //
  //   return progressDouble;
  // }

  // addPoints(int points) {
  //   //add points
  //   _loggedUser!.rankTotalPoints += points;
  //   //calculate rank
  //   if (_loggedUser!.rankTotalPoints >= _rankThresholds[_loggedUser!.rankLevel]) {
  //     _loggedUser!.rankLevel += 1;
  //     setUserLeveledUp(true);
  //   }
  // }

  // createDefaultLoggedUser(String userId) {
  //   _loggedUser = LoggedUser(
  //       documentId: userId,
  //       username: 'uczeń-' + getRandomString(5),
  //       isPro: false,
  //       // rankLevel: 0,
  //       // rankTotalPoints: 0,
  //       // qVersions: [1,1,1],
  //       qListNew: [],
  //       qListPractice: [],
  //       qListNotShown: []);
  // }

  // setLoggedUserChanged(bool status) {
  //   //some flag to keep track if user has changed (helpful in some loops)
  //   _loggedUserChanged = status;
  // }

  //////// NEW ////////

  // void createUser(String uid) {
  //   log('User created');
  //   state = state.copyWith(id: uid);
  //   log(state.toString());
  // }

  void getUserFromDb(String uid) async {
    //try to fetch from db
    final response = await AsyncValue.guard(() => _ref.read(databaseService).getUser(uid));
    if (response.value is AppUser) {
      state = response.value!;
      log('/// UserService: Got User from DB ///');
      log(response.value.toString());
      // _ref.read(routeController).navigate(MyScreen.menu);
    } else {
      //if error, then assume that user is new and wasn't yet created
      createUser(uid);
      final updateResult = updateUserInDb();
      if (updateResult is Failure) {
        log('/// UserService: Error updating user ///');
        return;
      }
      // _ref.read(routeController).navigate(MyScreen.menu);
    }
    _ref.read(appStateNotifierProvider.notifier).userSignedIn();
  }

  void createUser(String uid) {
    log('/// UserService: Created emptyUser ///');
    state = state.copyWith(id: uid);
    log(state.toString());
  }

  Future<Object> updateUserInDb() async {
    try {
      await _ref.read(databaseService).updateUser(state);
      return Success();
    } catch (e) {
      debugPrint(errorUpdateUserInDb);
      return Failure(errorUpdateUserInDb);
    }
  }

  clearUser() { //clearing user after user pressed signOut button
    state = AppUser.empty();
  }

  void moveQuestionToHidden(String qId) {
    state = state.copyWith(hiddenQuestionIds: [
      ...state.hiddenQuestionIds,
      qId,
    ]);
    log('HiddenList: ${state.hiddenQuestionIds}');
  }

  void removeQuestionFromHidden(String qId) {
    state = state.copyWith(hiddenQuestionIds: [ //create new list using copyWith
      for (final id in state.hiddenQuestionIds) //check current elements in list
        if (id != qId) id, //return anything but that one qId
    ]);
    log('HiddenList: ${state.hiddenQuestionIds}');
  }

  Future<void> goPro() async {
    state = state.copyWith(isPro: true);
    await _ref.read(databaseService).updateUser(state);
  }

  //////// END NEW ////////


  // Future<Object> createUserLocal(String userId) async {
  //   try {
  //     _loggedUser = await _databaseService.getUserData(userId);
  //     // loggedUserStreamController.add(_loggedUser);
  //     return Success();
  //   } catch (e) {
  //     debugPrint(errorGetUserDataFromDB);
  //     //if there's an error, assume that user was not yet created
  //     await createDefaultLoggedUser(userId);
  //     return Success();
  //   }
  // }

  // Future<Object> rollUserBack() async {
  //   try {
  //     _loggedUser = await _databaseService.getUserData(_loggedUser!.documentId);
  //     return Success();
  //   } catch (e) {
  //     debugPrint(errorRollBackUser);
  //     return Failure(errorRollBackUser);
  //   }
  // }




  // List<int> compareQVersion(List<int> qVersions) {
  //   debugPrint('/// Checking if questions are up to date ///');
  //   List<int> outdatedQLists = [];
  //
  //   //Every user
  //   if (qVersions[0] != loggedUser!.qVersions[0]){
  //     outdatedQLists.add(1);
  //     debugPrint('questions1 outdated');
  //   }
  //   //Pro user
  //   if (loggedUser!.isPro)
  //     {
  //       if (qVersions[1] != loggedUser!.qVersions[1]){
  //         outdatedQLists.add(2);
  //         debugPrint('questions2 outdated');
  //       }
  //       if (qVersions[2] != loggedUser!.qVersions[2]){
  //         outdatedQLists.add(3);
  //         debugPrint('questions3 outdated');
  //       }
  //     }
  //   return outdatedQLists;
  // }

  // Future<void> updateQNewList(List<Question> qListGlobal) async {
  //   for (var question in qListGlobal) {
  //     //check if question is on any list
  //     bool isOnAnyList = isQuestionOnAnyList(question.id);
  //
  //     if (!isOnAnyList) {
  //       //jeśli nie, stwórz jego mapę i zapisz do qNewList
  //       QMap qMap = createDefaultQMap(question.id);
  //       addQMapToNew(qMap);
  //       //set flag, that user object was changed
  //       setLoggedUserChanged(true);
  //     }
  //   }
  //   //if loggedUser changed, update it on DB at the end
  //   if (_loggedUserChanged) {
  //     await _databaseService.updateUser(_loggedUser!);
  //     setLoggedUserChanged(false);
  //   }
  // }

  // prepareRanks(List<String> rankNames, List<int> rankThresholds) {
  //   debugPrint('/// Preparing ranks data... ///');
  //   _rankNames = rankNames;
  //   _rankThresholds = rankThresholds;
  // }

  // updateQVersion(List<int> qVersions) {
  //   if (loggedUser!.isPro) {
  //     _loggedUser!.qVersions = qVersions;
  //   } else {
  //     _loggedUser!.qVersions[0] = qVersions[0];
  //   }
  //   }
  //
  // bool isQuestionOnAnyList(String questionId) {
  //   return isQuestionInQListNew(questionId) != null ||
  //       isQuestionInPracticeList(questionId) != null ||
  //       isQuestionInNotShownList(questionId) != null;
  // }

  // QMap? isQuestionInQListNew(String questionId) {
  //   // return _loggedUser!.qListNew.firstWhereOrNull((qMap) => qMap.id == questionId);
  // }
  //
  // QMap? isQuestionInPracticeList(String questionId) {
  //   // return _loggedUser!.qListPractice.firstWhereOrNull((qMap) => qMap.id == questionId);
  // }
  //
  // QMap? isQuestionInNotShownList(String questionId) {
  //   // return _loggedUser!.qListNotShown.firstWhereOrNull((qMap) => qMap.id == questionId);
  // }

  // removeQuestionFromAnyQList(String questionId) {
  //   // _loggedUser!.qListNew.removeWhere((e) => e.id == questionId);
  //   // _loggedUser!.qListPractice.removeWhere((e) => e.id == questionId);
  //   // _loggedUser!.qListNotShown.removeWhere((e) => e.id == questionId);
  // }

  // QMap createDefaultQMap(String? qId) {
  //   return QMap(id: qId, dateModified: DateTime.now().toString().substring(0, 10), fibNum: 0);
  // }
  //
  // List<QMap> getQMapsFromNewList(int qLevel) {
  //   //return only first 10 elements
  //   // return _loggedUser!.qListNew.slice(0, min(9, _loggedUser!.qListNew.length));
  // }

  // List<QMap> getTodayPracticeQMapList() {
  //   debugPrint('/// UserService: Getting TodayPracticeQMapList... ///');
  //   List<QMap> todayPracticeList = [];
  //
  //   if (_loggedUser!.qListPractice.isNotEmpty) {
  //     for (var qMap in _loggedUser!.qListPractice) {
  //       if (getDateDifferenceInDays(qMap) < 1) {
  //         todayPracticeList.add(qMap);
  //       }
  //     }
  //   }
  //   return todayPracticeList;
  // }

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

  // moveQMapToPractice(String qId, int qLevel, bool update) async {
  //   debugPrint('/// Moving QMap to practice list... ///');
  //   //Get QMap by ID from qNewList
  //   QMap? qMap = getQMapAndRemove(qId, qType, qLevel);
  //
  //   if (qMap != null) {
  //     //if update, set new Date and FibNum
  //     if (update) {
  //       qMap.dateModified = _today.toString().substring(0, 10);
  //       qMap.fibNum = getNextFibNum(qMap.fibNum);
  //       // setLoggedUserChanged(true);
  //     }
  //     //add question QMap to Practice list
  //     await addQMapToPractice(qMap);
  //   }
  // }

  // moveQMapToNew(String qId) async {
  //   //Cut it from NotShownList
  //   QMap? qMap = _loggedUser!.qListNotShown.firstWhereOrNull((element) => element.id == qId);
  //   if (qMap != null) {
  //     _loggedUser!.qListNotShown.remove(qMap);
  //     await addQMapToNew(qMap);
  //     debugPrint('/// US: Moved QMap to NotShow list ///');
  //   }
  // }
  //
  // moveQMapToNotShown(String qId) async {
  //   //Get QMap by ID from qNewList
  //   QMap? qMap = _loggedUser!.qListNew.firstWhereOrNull((element) => element.id == qId);
  //   if (qMap != null) {
  //     _loggedUser!.qListNew.remove(qMap);
  //     await addQMapToNotShown(qMap);
  //     debugPrint('/// US: Moved QMap to NotShown list ///');
  //   }
  // }

  // QMap? getQMapAndRemove(String qId) {
  //   //method cuts out qMap from it's list and returns it
  //   QMap? qMap =
  //
  //         return qMap;
  //
  // }

  // addQMapToNew(QMap qMap) {
  //   //Before this method, it is checked if qMap is on any map.
  //   //So there's no need to check it again
  //   // setLoggedUserChanged(true);
  //   _loggedUser!.qListNew.add(qMap);
  //
  //   // switch (qLevel) {
  //   //   case 1:
  //   //     _loggedUser!.qListNew1.add(qMap);
  //   //     break;
  //   //   case 2:
  //   //     _loggedUser!.qListNew2.add(qMap);
  //   //     break;
  //   //   case 3:
  //   //     _loggedUser!.qListNew3.add(qMap);
  //   //     break;
  //   // }
  // }


  // addQMapToNotShown(QMap qMap) {
  //   _loggedUser!.qListNotShown.add(qMap);
  // }

  // wipeUser() {
  //   // _loggedUser!.rankLevel = 0;
  //   // _loggedUser!.rankTotalPoints = 0;
  //   _loggedUser!.qListNew.clear();
  //   _loggedUser!.qListPractice.clear();
  //   _loggedUser!.qListNotShown.clear();
  //
  // }


  //
  // getDateDifferenceInDays(QMap question) {
  //   DateTime parsedDate = DateTime.parse(question.dateModified);
  //   DateTime whenToPractice = parsedDate.add(Duration(days: question.fibNum));
  //   return whenToPractice.difference(_today).inDays;
  // }
  //
  // getNextFibNum(int currentFibNum) {
  //   int currentFibNumIndex = fibSeries.indexOf(currentFibNum);
  //   return fibSeries[currentFibNumIndex + 1];
  // }

  // Future<Object> changeUserName(String username) async {
  //   //check if name was even changed
  //   if (username == _loggedUser!.username) return Success();
  //
  //   //validate characters
  //   Object validateResult = validateUsername(username);
  //   if (validateResult is Failure) return validateResult;
  //
  //   //check if username is not taken
  //   try {
  //     bool isUsernameAvailableResult =
  //         await _databaseService.checkIfUsernameIsAvailable(_loggedUser!.documentId, username);
  //     if (!isUsernameAvailableResult) return Failure(errorUsernameTaken);
  //     //if TRUE, update user on DB
  //     _loggedUser!.username = username;
  //     await updateLoggedUserInDb();
  //     return Success();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return Failure(errorDbGeneric);
  //   }
  // }

  // Widget getQListIcon(String qId) {
  //   // if (isQuestionInPracticeList(qId) != null) {
  //   //   return qListIcons['practice']!;
  //   // }
  //   if (isQuestionInNotShownList(qId) != null) {
  //     return qListIcons['notShown']!;
  //   } else {
  //     return qListIcons['none']!;
  //   }
  // }
}
