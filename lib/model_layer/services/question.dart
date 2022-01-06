import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  Future prepareKnownQuestion() async {

    //get ID of first KnownQuestion from user qKnownList
    var result = await _userService.getKnownQuestionID();
    
    if (result is Success) {
      var qId = result.response as String;
      _singleKnownQuestion = qListGlobal.firstWhereOrNull((element) => element.id == qId);
      debugPrint('single question known: $_singleKnownQuestion');
    }
    else {
      _singleKnownQuestion = null;
    }
  }


  Future moveQuestionToPractice(String questionId) async {

    //Place Question in the right list
    var updatedUser = await _userService.moveQuestionToPractice(questionId);

    if (updatedUser != null) {
      //Send updated User to database
    }

  }

}