import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/models/question_map.dart';
import 'package:sepapka/model_layer/services/database.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:collection/collection.dart';

import '../../locator.dart';
import '../question.dart';

class QuestionService{

  //Services Injection
  UserService _userService = serviceLocator.get<UserService>();
  DatabaseService _databaseService = serviceLocator.get<DatabaseService>();

  //Properties
  List<Question> qListGlobal = [q1, q2, q3, q4, q5, q6];
  Question? _singleKnownQuestion;


  //Getters
  Question? get singleKnownQuestion => _singleKnownQuestion;


  //Methods
  Future prepareNewQuestion() async {

    //get ID of first KnownQuestion from user qKnownList
    var result = await _userService.getNewQuestionQMap();
    
    if (result is Success) {
      var qMap = result.object as QMap;
      _singleKnownQuestion = qListGlobal.firstWhereOrNull((element) => element.id == qMap.id);
      debugPrint('single question known: $_singleKnownQuestion');
    }
    else {
      _singleKnownQuestion = null;
    }
  }


  Future<Object> moveNewQuestionToPractice(String questionId) async {

    //Place Question in the right list and get updated User object
    var moveResult = await _userService.moveNewQuestionToPractice(questionId);

    if (moveResult is Success) {
      //If question was moved successfully, the response contains updated user
    return Success();
    }
    else {
      //return error message back
      return moveResult;
    }
  }

}