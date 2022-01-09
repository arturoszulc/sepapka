import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/model_layer/services/database.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts.dart';

import '../../locator.dart';
import '../question.dart';

class QuestionService {
  //Services Injection
  UserService _userService = serviceLocator.get<UserService>();
  DatabaseService _databaseService = serviceLocator.get<DatabaseService>();

  //Properties
  List<Question> qListGlobal = [q1, q2, q3, q4, q5, q6];
  Question? _currentQuestion;
  List<BMap> _bMapList = []; //shuffled list of answers & colors for butotns
  QuestionStatus _qStatus = QuestionStatus.noAnswer;

  //Getters
  Question? get currentQuestion => _currentQuestion;

  List<BMap> get bMapList => _bMapList;

  QuestionStatus get qStatus => _qStatus;

  //Methods

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
    var result = await _userService.getNewQuestionQMap();
    if (result.object is QMap) {
      //if question exists, prepare it and set AMap
      _currentQuestion = qListGlobal.firstWhereOrNull((element) => element.id == result.object.id);
      if (_currentQuestion != null) {
        _bMapList = [
          BMap(answer: _currentQuestion!.a1, color: normalButtonColor),
          BMap(answer: _currentQuestion!.a2, color: normalButtonColor),
          BMap(answer: _currentQuestion!.a3, color: normalButtonColor),
          BMap(answer: _currentQuestion!.a4, color: normalButtonColor),
        ];
        _bMapList.shuffle();
      }
      return Success();
    } else {
      _currentQuestion = null;
      return Failure(errorResponse: result.errorResponse, code: result.errorCode);
    }
  }
}
