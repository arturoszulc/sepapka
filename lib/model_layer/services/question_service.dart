import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/global_data.dart';
import 'package:sepapka/model_layer/models/remark.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/file_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts/colors.dart';
import 'package:sepapka/utils/consts/errors_messages.dart';
import 'package:sepapka/utils/consts/question.dart';
import 'package:sepapka/utils/methods.dart';

import '../../locator.dart';
import '../models/question.dart';

class QuestionService {
  //Services Injection
  final _userService = serviceLocator.get<UserService>();
  final _databaseService = serviceLocator.get<DatabaseService>();
  final _fileService = serviceLocator.get<FileService>();

  //Properties
  GlobalData? globalData; //downloaded from DB
  List<Question>? qListGlobal; //all questions
  List<Question> qListSession = []; //questions based on chosen Category and Level
  // List<Question> qListSession = []; //10 questions cut out from qListLocal for current session
  List<Question> qListGlobalFiltered = [];
  int qListCurrentStartLength = 0;
  int numberOfRightAnswers = 0;
  Question? currentQuestion;

  //making properties below PRIVATE and creating getter and setter for them (to access them externally) is THE SAME
  //as making them public in the first place.
  //So I should make only those variables _private which shouldn't be modified in simple way

  QuestionStatus qStatus = QuestionStatus.noAnswer;
  int qLevel = 0;
  int qCategoryNum = 0; //int corresponds to index of qList

  //Question List filters
  // FilterQuestion qFilter = FilterQuestion.all;
  int filterType = 0; //0 = all, 1 = visible 2 = hidden
  int filterLevel = 0; // 0 = all, 1 = lvl1, 2 = lvl2, 3 = lvl3
  int filterCategory = 0; //corresponds to qCategories
  bool filterTypeChanged = false;
  bool filterLevelChanged = false;
  bool filterCategoryChanged = false;

  List<int> numOfQuestionsByLevel = [];
  List<int> numOfQuestionsByCategory = [];

  List<BMap> bMapList = []; //shuffled list of answers & colors for buttons
  bool isSessionFinished = false;


  //Methods

  Future<Object> prepareGlobalData() async {
    //Get GlobalData from DB
    try {
      globalData = await _databaseService.getGlobalData();
    } catch (e) {
      debugPrint(e.toString());
      return Failure(errorGetGlobalData);
    }


    //compare questionVersion from DB with those in LoggedUser object
    //retrieve list of outdated QuestionLists
    List<int> outdatedQLists = _userService.compareQVersion(globalData!.qVersions);

    //get Question List based on compareResult
    Object getQuestionResult = await getGlobalQuestionLists(outdatedQLists);
    if (getQuestionResult is Failure) return getQuestionResult;

    //update qListGlobal and count number of questions by level
    qListGlobal = getQuestionResult as List<Question>;

    //also update qListFiltered, so it won't be empty
    qListGlobalFiltered = List<Question>.from(qListGlobal!);

    //update local user question version and qNewList (if there any any new questions)
    _userService.updateQVersion(globalData!.qVersions);
    await _userService.updateQNewLists(qListGlobal!);

    debugPrint('/// QuestionService: Finished preparing GlobalData ///');
    return Success();
  }

  Future<Object> getGlobalQuestionLists(List<int> outdatedQLists) async {
    // if all question lists are up to date, try to take questions from local JSON files
    if (outdatedQLists.isEmpty) {
      Object getLocalQuestionResult = await _fileService.getQuestionListFromFile();
      if (getLocalQuestionResult is List<Question>) {
        return getLocalQuestionResult;
      }
      //if reading file failed, then new lists from DB has to be downloaded
      //to do this, fill outdatedQList with lists to download
      else {
        outdatedQLists.add(1);
        if (_userService.loggedUser!.isPro) {
          outdatedQLists.addAll([2, 3]);
        }

      }
    }

    //Initializing list that will allow merging couple of lists from DB
    List<Question> questionListFromDB = [];

    for (int outdatedList in outdatedQLists) {
      List<Question>? questionList = await _databaseService.getQuestionList(list: outdatedList);
      //if failed to download, interrupt whole method
      if (questionList == null) return Failure(errorGetQListFromDB);
      //if succeeded, add it to main list
      questionListFromDB += questionList;
    }

    //after downloading all question lists, save questions to local JSON file
    Object saveQuestionToFileResult = await _fileService.saveQuestionListToFile(questionListFromDB);
    if (saveQuestionToFileResult is Failure) return saveQuestionToFileResult;
    return questionListFromDB;
  }

  setQuestionLevel(int level) {
    qLevel = level;
  }

  setQuestionCategory(int catNumber) {
    qCategoryNum = catNumber;
  }

  prepareSession() async {
    //reset isSessionFinished flag and num of right answers
    isSessionFinished = false;
    numberOfRightAnswers = 0;
    //clear the old qListSession
    qListSession = List<Question>.from(qListGlobal!);
    //reset current points counter
    // _currentSessionUserPoints = 0;

    //filter by Level
    if (qLevel != 0) {
      qListSession.removeWhere((e) => e.level != qLevel);
    }

    //filter by Category

    if (qCategoryNum != 0) {
      qListSession.removeWhere((e) => e.label != qCategoryNum);
    }

    //now cut out of qListLocal any question that is on NotShownList
    qListSession.removeWhere((e) => _userService.isQuestionInNotShownList(e.id) != null);


    //get maximum 10 questions to session list
    // qListSession = getSetOfQuestions();


    //set starting length of _qListCurrent for session progress bar
    qListCurrentStartLength = qListSession.length;
  }

  Future checkAnswer(String answer) async {
    //remove question from qListLocal and qListSession
    removeCurrentQuestionFromSession();
    // qListSession.removeAt(0);

    //If right answer
    if (answer == currentQuestion!.a1) {
      //set QuestionStatus
      qStatus = QuestionStatus.rightAnswer;
      //set button color
      bMapList.firstWhere((element) => element.answer == answer).color = rightButtonColor;
      //add one to countRightAnswers
      numberOfRightAnswers += 1;

    }
    //if wrong answer
    else {
      //get question back, at the end of the current list
      // qListLocal.add(currentQuestion!);
      // qListSession.add(currentQuestion!);

      qStatus = QuestionStatus.wrongAnswer;
      //color wrong button
      bMapList.firstWhere((element) => element.answer == answer).color = wrongButtonColor;
      //color right button
      bMapList.firstWhere((element) => element.answer == currentQuestion!.a1).color =
          rightButtonColor;
    }
  }

  Future<Object> getNextQuestion() async {
    qStatus = QuestionStatus.noAnswer;



    //if there is a question on the list
    if (qListSession.isNotEmpty) {
      //prepare question
      currentQuestion = qListSession.first;
      //create new BMap
      createBMap();
      //success means there's question to show
      return Success();
    } else {
      //if theres no questions left on the list
      return Failure();
    }
  }

  List<Question> getSetOfQuestions() {
    //get maximum 10 questions to session list
    //warning: //.toList() below makes the list growable, so I can add or remove elements from it
    return qListSession.slice(0, min(3, qListSession.length)).toList();
  }
  Object endSession() {
    currentQuestion = null;
    isSessionFinished = true;
    return Success();
  }

  removeCurrentQuestionFromSession() {
    qListSession.removeAt(0);
  }

  double getProgressPercentSession() {
    return (qListCurrentStartLength - qListSession.length) / qListCurrentStartLength;
  }
  String getUserScore() {
    double scoreDouble = (numberOfRightAnswers / qListCurrentStartLength) * 100;
    String scoreString = scoreDouble.toStringAsFixed(1);
    return scoreString;
  }

  createBMap() {
    if (currentQuestion != null) {
      bMapList = [
        BMap(answer: currentQuestion!.a1, color: normalButtonColor),
        BMap(answer: currentQuestion!.a2, color: normalButtonColor),
        BMap(answer: currentQuestion!.a3, color: normalButtonColor),
        BMap(answer: currentQuestion!.a4, color: normalButtonColor),
      ];
      //shuffle buttons
      bMapList.shuffle();
    } else {
      //reset QuestionStatus
      qStatus = QuestionStatus.noAnswer;
    }
  }

  // doNotShowThisQuestionAnymore() async {
  //   await _userService.moveQMapToNotShown(currentQuestion!.id);
  //   _userService.updateLoggedUserInDb();
  // }

  moveQuestionBackToShown(String qId) async {
    await _userService.moveQMapToNew(qId);
    _userService.updateLoggedUserInDb();
  }

  Future<Object> sendQuestionRemark(String remark) async {
    //validate data
    Object validateResult = validateRemark(remark);
    if (validateResult is Failure) return validateResult;
    try {
      _databaseService.sendQuestionRemark(Remark(
        date: DateTime.now(),
        question: currentQuestion!.id,
        text: remark,
      ));
      return Success();
    } catch (e) {
      debugPrint(e.toString());
      return Failure(errorSendingRemark);
    }
  }

  List<int> countQuestionsByLevel() {
    debugPrint('*** countQuestionsByLevel() deployed ***');
    numOfQuestionsByLevel = [0, 0, 0, 0];
    for (Question question in qListGlobal!) {
      if (_userService.isQuestionInNotShownList(question.id) == null) {
        if (question.level == 1) numOfQuestionsByLevel[1] += 1;
        if (question.level == 2) numOfQuestionsByLevel[2] += 1;
        if (question.level == 3) numOfQuestionsByLevel[3] += 1;
      }
    }
    //first number is total number of questions
    numOfQuestionsByLevel[0] =
        numOfQuestionsByLevel[1] + numOfQuestionsByLevel[2] + numOfQuestionsByLevel[3];
    return numOfQuestionsByLevel;
  }

  List<int> countQuestionsByCategory() {
    numOfQuestionsByCategory = [0, 0, 0, 0, 0];
    if (qLevel == 0) {
      for (Question question in qListGlobal!) {
        if (_userService.isQuestionInNotShownList(question.id) == null) {
          if (question.label == 1) numOfQuestionsByCategory[1] += 1;
          if (question.label == 2) numOfQuestionsByCategory[2] += 1;
          if (question.label == 3) numOfQuestionsByCategory[3] += 1;
          if (question.label == 4) numOfQuestionsByCategory[4] += 1;
        }
      }
    } else {
      for (Question question in qListGlobal!) {
        if (_userService.isQuestionInNotShownList(question.id) == null) {
          if (question.level == qLevel) {
            if (question.label == 1) numOfQuestionsByCategory[1] += 1;
            if (question.label == 2) numOfQuestionsByCategory[2] += 1;
            if (question.label == 3) numOfQuestionsByCategory[3] += 1;
            if (question.label == 4) numOfQuestionsByCategory[4] += 1;
          }
        }
      }
    }

    numOfQuestionsByCategory[0] = numOfQuestionsByCategory[1] +
        numOfQuestionsByCategory[2] +
        numOfQuestionsByCategory[3] +
        numOfQuestionsByCategory[4];

    return numOfQuestionsByCategory;
  }

  getFilteredQuestionList() {
    //calling this function means that some filter changed
    // so start with clearing the old one
    qListGlobalFiltered = List<Question>.from(qListGlobal!);

    //apply three filters
    filterListByType();
    filterListByLevel();
    filterListByCategory();

    //reset all flags
    // filterTypeChanged = false;
    // filterLevelChanged = false;
    // filterCategoryChanged = false;
  }

  filterListByType() {
    //filter only if type is different than 0 (0 = all)
    if (filterType != 0) {
      if (filterType == 1) {
        qListGlobalFiltered.removeWhere((e) => _userService.isQuestionInQListNew(e.id) == null);
      }
      if (filterType == 2) {
        qListGlobalFiltered.removeWhere((e) => _userService.isQuestionInNotShownList(e.id) == null);
      }
    }
  }

  filterListByLevel() {
    //filter only if level was chosen (0 = all)
    if (filterLevel != 0) {
      qListGlobalFiltered.removeWhere((e) => e.level != filterLevel);
    }
  }

  filterListByCategory() {
    //filter only if category was chosen (0 = all)
    if (filterCategory != 0) {
      qListGlobalFiltered.removeWhere((e) => e.label != filterCategory);
    }
  }
}
