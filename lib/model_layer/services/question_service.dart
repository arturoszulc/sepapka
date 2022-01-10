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
  List<BMap> _bMapList = []; //shuffled list of answers & colors for butotns
  QuestionStatus _qStatus = QuestionStatus.noAnswer;

  //Getters
  Question? get currentQuestion => _currentQuestion;

  List<BMap> get bMapList => _bMapList;

  QuestionStatus get qStatus => _qStatus;

  //Methods

  Future<bool> prepareGlobalData() async {
    //Get questionVersion number from DB
    int? qVersion = await _databaseService.getQuestionVersion();
    debugPrint('wersja pytań DB: $qVersion');

    if (qVersion is int) {
      //if version is downloaded, compare it with local
      bool compareResult = _userService.compareQVersion(qVersion);

      if (compareResult == true) {
        debugPrint('/// wersja pytań jest taka sama ///');
        _qListGlobal = await _fileService.getQuestionListFromFile();
      }
      if (compareResult == false) {
        debugPrint('/// wersja pytań jest inna ///');
        //if local qVersion is different, get new qList from DB
        _qListGlobal = await _databaseService.getQuestionList();

        //save new qList to new JSON File
        if (_qListGlobal != null) {
          bool result = await _fileService.saveQuestionListToFile(_qListGlobal!);
          if (result) {
            //add any new questions to user qNewList
            await _userService.updateQNewList(_qListGlobal!);
            _userService.loggedUser!.qVersion = qVersion;
            debugPrint('wersja pytań usera: ${_userService.loggedUser!.qVersion}');
          }
        }
      }
    } else {
      debugPrint(errorQVersion);
    }
    return false;
  }

  Future checkAnswer(String answer) async {
    //If right answer
    if (answer == _currentQuestion!.a1) {
      //set QuestionStatus
      _qStatus = QuestionStatus.rightAnswer;
      //set button color
      _bMapList.firstWhere((element) => element.answer == answer).color = rightButtonColor;
      //move question to Practice List
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

  Future prepareNewQuestion() async {
    //reset QuestionStatus
    _qStatus = QuestionStatus.noAnswer;

    //get QMap of first NewQuestion from user qNewList
    QMap? qMap = _userService.getNewQuestionQMap();
    if (qMap != null) {
      //if question exists, prepare it and set AMap
      _currentQuestion = _qListGlobal!.firstWhereOrNull((element) => element.id == qMap.id);
      if (_currentQuestion != null) {
        _bMapList = [
          BMap(answer: _currentQuestion!.a1, color: normalButtonColor),
          BMap(answer: _currentQuestion!.a2, color: normalButtonColor),
          BMap(answer: _currentQuestion!.a3, color: normalButtonColor),
          BMap(answer: _currentQuestion!.a4, color: normalButtonColor),
        ];
        _bMapList.shuffle();
      }
    } else {
      //if question does not exist, set it to null
      _currentQuestion = null;
    }
  }
}
