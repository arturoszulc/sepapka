import 'package:flutter/foundation.dart';
import 'package:sepapka/model_layer/services/database.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts.dart';
import 'package:collection/collection.dart';

import '../../locator.dart';
import '../question.dart';

class QuestionService{

  List<Question> qListGlobal = [q1, q2, q3, q4, q5, q6];
  Question? _singleKnownQuestion;

  Question? getSingleKnownQuestion() {
    return _singleKnownQuestion;
  }

  //Services Injection
  UserService _userService = serviceLocator.get<UserService>();
  DatabaseService _databaseService = serviceLocator.get<DatabaseService>();

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

  //mark as known
  Future markQuestionAsKnown(String questionId) async {
    var updatedUser = await _userService.addQuestionToKnown(questionId);

    //create Update User in Database Method in DataBase Service

  }
  //move to unknown

  //move to new



}