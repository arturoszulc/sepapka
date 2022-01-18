import 'package:collection/src/iterable_extensions.dart';
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
  Question? _currentQuestion;
  QuestionStatus _qStatus = QuestionStatus.noAnswer;
  QuestionType _qType = QuestionType.newQuestion;
  List<BMap> _bMapList = []; //shuffled list of answers & colors for butotns

  //Getters
  Question? get currentQuestion => _currentQuestion;

  QuestionStatus get qStatus => _qStatus;

  QuestionType get qType => _qType;

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
    // if User has qVersion up to date, take questions from JSON file
    if (compareResult == true) {
      Object getLocalQuestionResult = await _fileService.getQuestionListFromFile();
      return getLocalQuestionResult;
    }
    //if user has outdated qVersion, download new from DB
    else {
      List<Question>? questionListFromDB = await _databaseService.getQuestionList();
      if (questionListFromDB == null) return Failure(errorGetQListFromDB);
      //save questions to local JSON file
      Object saveQuestionToFileResult = await _fileService.saveQuestionListToFile(questionListFromDB);
      if (saveQuestionToFileResult is Failure) return saveQuestionToFileResult;
      return questionListFromDB;
    }
  }

  Future checkAnswer(String answer) async {
    //If right answer
    if (answer == _currentQuestion!.a1) {
      //set QuestionStatus
      _qStatus = QuestionStatus.rightAnswer;
      //set button color
      _bMapList.firstWhere((element) => element.answer == answer).color = rightButtonColor;
      //move question to Practice List
      ///TODO: check if question is New or Practice and deicde where to put it

      await _userService.moveNewQuestionToPractice(_currentQuestion!.id);
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
      //move question to the end of New List
      _userService.moveNewQuestionToNew(_currentQuestion!.id);
    }
  }

  Future prepareQuestion(QuestionType qType) async {
    //reset QuestionStatus
    _qStatus = QuestionStatus.noAnswer;

    //get question based on type
    if (qType == QuestionType.newQuestion) {
      _currentQuestion = getNewQuestion();
      _qType = QuestionType.newQuestion;
    } else {
      _currentQuestion = getPracticeQuestion();
      _qType = QuestionType.practiceQuestion;
    }
    //if question exists, prepare button map
    if (_currentQuestion != null) {
      _bMapList = [
        BMap(answer: _currentQuestion!.a1, color: normalButtonColor),
        BMap(answer: _currentQuestion!.a2, color: normalButtonColor),
        BMap(answer: _currentQuestion!.a3, color: normalButtonColor),
        BMap(answer: _currentQuestion!.a4, color: normalButtonColor),
      ];
      _bMapList.shuffle();
    }
  }

  Question? getNewQuestion() {
    //get QMap of first NewQuestion from user qNewList
    QMap? qMap = _userService.getNewQuestionQMap();
    if (qMap != null) {
      //if question exists, prepare it and set AMap
      return _qListGlobal!.firstWhereOrNull((element) => element.id == qMap.id);
    } else {
      //if question does not exist, set it to null
      _currentQuestion = null;
    }
  }

  Question? getPracticeQuestion() {
    //get QMap of first NewQuestion from user qNewList
    QMap? qMap = _userService.getPracticeQuestionQMap();
    if (qMap != null) {
      //if question exists, prepare it and set AMap
      return _qListGlobal!.firstWhereOrNull((element) => element.id == qMap.id);
    } else {
      //if question does not exist, set it to null
      _currentQuestion = null;
    }
  }
}
