import 'package:flutter/foundation.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/file_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts.dart';

import '../../locator.dart';
import '../models/question.dart';

class QuestionService {
  //Services Injection
  UserService _userService = serviceLocator.get<UserService>();
  DatabaseService _databaseService = serviceLocator.get<DatabaseService>();
  FileService _fileService = serviceLocator.get<FileService>();

  //Properties
  List<Question>? _qListGlobal;
  List<Question> _qListCurrent = [];
  Question? _currentQuestion;
  QuestionStatus _qStatus = QuestionStatus.noAnswer;
  QuestionType _qType = QuestionType.newQuestion;
  int _qLevel = 0;
  List<BMap> _bMapList = []; //shuffled list of answers & colors for buttons

  //Getters
  Question? get currentQuestion => _currentQuestion;

  QuestionStatus get qStatus => _qStatus;

  QuestionType get qType => _qType;

  int get qLevel => _qLevel;

  List<BMap> get bMapList => _bMapList;

  //Methods

  Future<Object> prepareGlobalData() async {
    //Get questionVersion number from DB
    int? qVersion = await _databaseService.getQuestionVersion();
    if (qVersion is! int) return Failure(errorGetQVersionFromDB);

    //after downloading qVersion from DB, compare it with local LoggedUser.qVersion.
    bool compareResult = _userService.compareQVersion(qVersion);

    //get Question List based on compareResult
    Object getQuestionResult = await getQuestionList(compareResult);
    if (getQuestionResult is Failure) return getQuestionResult;

    //update qListGlobal variable
    _qListGlobal = getQuestionResult as List<Question>;

    //update local user question version and qNewList (if there any any new questions
    _userService.updateQVersion(qVersion);
    await _userService.updateQNewList(_qListGlobal!);

    debugPrint('/// SUCCESS: FINISHED PREPARING DATA ///');
    return Success();
  }

  Future<Object> getQuestionList(bool compareResult) async {
    // if User has qVersion up to date, try to take questions from JSON file
    if (compareResult == true) {
      Object getLocalQuestionResult = await _fileService.getQuestionListFromFile();
      if (getLocalQuestionResult is List<Question>) return getLocalQuestionResult;
    }

    //if user has outdated qVersion, or couldn't read file, download questions from DB
    List<Question>? questionListFromDB = await _databaseService.getQuestionList();
    if (questionListFromDB == null) return Failure(errorGetQListFromDB);
    //save questions to local JSON file
    Object saveQuestionToFileResult = await _fileService.saveQuestionListToFile(questionListFromDB);
    if (saveQuestionToFileResult is Failure) return saveQuestionToFileResult;
    return questionListFromDB;
  }

  Future checkAnswer(String answer) async {

    //remove question from _qListCurrent
    _qListCurrent.removeAt(0);

    //If right answer
    if (answer == _currentQuestion!.a1) {
      //set QuestionStatus
      _qStatus = QuestionStatus.rightAnswer;
      //set button color
      _bMapList.firstWhere((element) => element.answer == answer).color = rightButtonColor;
      //move question to Practice List
      if (_qType == QuestionType.newQuestion) {
        _userService.moveNewQuestionToPractice(_currentQuestion!.id);
      }
      if (_qType == QuestionType.practiceQuestion) {
        _userService.movePracticeQuestionToPractice(questionId: _currentQuestion!.id, update: true);
      }
    }
    //if wrong answer
    else {
      debugPrint('not right answer');
      _qStatus = QuestionStatus.wrongAnswer;
      //set wrong button
      _bMapList.firstWhere((element) => element.answer == answer).color = wrongButtonColor;
      //set right button
      _bMapList.firstWhere((element) => element.answer == _currentQuestion!.a1).color =
          rightButtonColor;
      //move question to the end of it's list, to try again
      if (_qType == QuestionType.newQuestion) {
        _userService.moveNewQuestionToNew(_currentQuestion!.id);
      }
      if (_qType == QuestionType.practiceQuestion) {
        _userService.movePracticeQuestionToPractice(questionId: _currentQuestion!.id, update: false);
      }
    }
  }


  prepareCurrentSessionData({required QuestionType qType, required int qLevel}) async {
    //set question type
    _qType = qType;
    //set question level
    _qLevel = qLevel;
    await prepareCurrentQuestionsBasedOnProps();
  }

  prepareCurrentQuestionsBasedOnProps() {
    //clear the old list
    _qListCurrent.clear();
    if (_qType == QuestionType.newQuestion) {
      //if user chose learning based on level
      if (_qLevel > 0) {
        for (Question question in _qListGlobal!) {
          if (question.level == _qLevel) {
            if (_userService.isQuestionInNewList(question.id) != null) {
              _qListCurrent.add(question);
            }
          }
        }
      }
    }
    if (_qType == QuestionType.practiceQuestion) {
      List<QMap> todayList = _userService.getTodayPracticeQMapList();
      for (QMap qMap in todayList) {
        _qListCurrent.add(_qListGlobal!.firstWhere((question) => question.id == qMap.id));
      }
    }
  }

  getNextQuestion() {

    //reset QuestionStatus
    _qStatus = QuestionStatus.noAnswer;

    if (_qListCurrent.isNotEmpty) {
      //prepare question
      _currentQuestion = _qListCurrent.first;
      //create new BMap
      createBMap();
    } else {
      _currentQuestion = null;
    }
  }

  createBMap() {
    if (_currentQuestion != null) {
      _bMapList = [
        BMap(answer: _currentQuestion!.a1, color: normalButtonColor),
        BMap(answer: _currentQuestion!.a2, color: normalButtonColor),
        BMap(answer: _currentQuestion!.a3, color: normalButtonColor),
        BMap(answer: _currentQuestion!.a4, color: normalButtonColor),
      ];
      //shuffle buttons
      _bMapList.shuffle();
    } else {
      //reset QuestionStatus
      _qStatus = QuestionStatus.noAnswer;
    }
  }

  Future<Object> resetUserProgress() async {
    //clear user lists
    await _userService.cleanUserQLists();
    //update qNewList
    await _userService.updateQNewList(_qListGlobal!);
    return Success();
  }
}
