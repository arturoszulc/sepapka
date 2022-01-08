import 'package:flutter/foundation.dart';
import 'package:sepapka/model_layer/models/answer_map.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/model_layer/services/database.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:collection/collection.dart';

import '../../locator.dart';
import '../question.dart';

class QuestionService {
  //Services Injection
  UserService _userService = serviceLocator.get<UserService>();
  DatabaseService _databaseService = serviceLocator.get<DatabaseService>();

  //Properties
  List<Question> qListGlobal = [q1, q2, q3, q4, q5, q6];
  Question? _singleKnownQuestion;
  List<AMap> _aMapList = []; //shuffled answers map with button colors

  //Getters
  Question? get singleKnownQuestion => _singleKnownQuestion;

  List<AMap> get aMapList => _aMapList;

  //Methods

  Future checkAnswer(String answer) async {
    if (answer == _singleKnownQuestion!.a1) {
      debugPrint('Right Answer');
      var aMap = _aMapList.firstWhere((element) => element.answer == answer);
      aMap.color = rightButtonColor;
    }
    else {
      debugPrint('not right answer');
      //set wrong button
      _aMapList.firstWhere((element) => element.answer == answer).color = wrongButtonColor;
      //set right button
      _aMapList.firstWhere((element) => element.answer == _singleKnownQuestion!.a1).color = rightButtonColor;
    }
  }

  Future prepareNewQuestion() async {
    //get ID of first KnownQuestion from user qKnownList
    var result = await _userService.getNewQuestionQMap();

    if (result is Success) {
      var qMap = result.object as QMap;
      _singleKnownQuestion =
          qListGlobal.firstWhereOrNull((element) => element.id == qMap.id);
      if (_singleKnownQuestion != null) {
        _aMapList = [
          AMap(answer: _singleKnownQuestion!.a1, color: normalButtonColor),
          AMap(answer: _singleKnownQuestion!.a2, color: normalButtonColor),
          AMap(answer: _singleKnownQuestion!.a3, color: normalButtonColor),
          AMap(answer: _singleKnownQuestion!.a4, color: normalButtonColor),
        ];
      }
    } else {
      _singleKnownQuestion = null;
    }
  }

  Future<Object> moveNewQuestionToPractice(String questionId) async {
    //Place Question in the right list and get updated User object
    var moveResult = await _userService.moveNewQuestionToPractice(questionId);

    if (moveResult is Success) {
      //If question was moved successfully, the response contains updated user
      return Success();
    } else {
      //return error message back
      return moveResult;
    }
  }
}
