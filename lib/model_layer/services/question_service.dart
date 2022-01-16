import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/file_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
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

  Future<bool> prepareGlobalData() async {
    //Get questionVersion number from DB
    int? qVersion = await _databaseService.getQuestionVersion();
    debugPrint('/// qVersion from DB: $qVersion ///');
    if (qVersion is! int) {
      debugPrint(errorQVersion);
      return false;
    }
    //after downloading qVersion from DB, compare it with local LoggedUser.qVersion.
    bool compareResult = _userService.compareQVersion(qVersion);

    //if it is identical, take questions from JSON file
    if (compareResult == true) {
      debugPrint('/// Downloading local question data ///');
      _qListGlobal = await _fileService.getQuestionListFromFile();
    }
    //if it is different
    if (compareResult == false) {
      debugPrint('/// Downloading question data from DB ///');
      //download questions from DB
      _qListGlobal = await _databaseService.getQuestionList();

      //save questions to local JSON file
      if (_qListGlobal != null) {
        bool result = await _fileService.saveQuestionListToFile(_qListGlobal!);
        if (result) {
          //then update user question version
          _userService.updateQVersion(qVersion);

          //and add any new questions to user qNewList
          await _userService.updateQNewList(_qListGlobal!);
          debugPrint('/// USER UPDATED ///');
        }
      }
    }
    return true;
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
    if (qType == QuestionType.newQuestion){
      _currentQuestion = getNewQuestion();
      _qType = QuestionType.newQuestion;
  }
    else {
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

    }
    else {
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
    }
    else {
      //if question does not exist, set it to null
      _currentQuestion = null;
    }
  }
}
