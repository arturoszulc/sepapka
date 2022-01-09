import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:sepapka/locator.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/question.dart';
import 'package:sepapka/model_layer/services/auth.dart';
import 'package:sepapka/model_layer/services/question.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts.dart';

class Manager extends ChangeNotifier {
  //Services Injection
  AuthService _authService = serviceLocator.get<AuthService>();
  UserService _userService = serviceLocator.get<UserService>();
  QuestionService _questionService = serviceLocator.get<QuestionService>();

  //Manager properties
  bool _loading = false;
  bool _isAnswered = false;

  //Manager getters
  bool get loading => _loading;

  //External Getters
  LoggedUser? get loggedUser => _userService.loggedUser;

  Question? get currentQuestion => _questionService.currentQuestion;
  List<BMap> get bMapList => _questionService.bMapList;
  QuestionStatus get qStatus => _questionService.qStatus;



  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  signIn({required String email, required String password}) async {
    //start loading app
    setLoading(true);
    // sign in and prepare data
    var result = await _authService.signInEmail(email, password);
    //if sign in succeeded, prepare question data
    if (result is Success) {

    }
    if (result is Failure) {
      debugPrint('${result.errorResponse}, errCode: ${result.code}');
    }

    // finish loading app
    setLoading(false);
  }
  checkAnswer(String answer) async {
    await _questionService.checkAnswer(answer);
    notifyListeners();
  }
  prepareNewQuestion() async {
    var result = await _questionService.prepareNewQuestion();
    if (result is Failure) {
      debugPrint('${result.errorResponse}, errCode: ${result.code}');
    }
  }
  preparePracticeQuestion() async {
  }

  moveQuestionToNew() {
  }

//   moveNewQuestionToPractice(String questionId) async {
//     var result = await _questionService.moveNewQuestionToPractice(questionId);
//     if (result is Success) {
//       debugPrint('moveNewQuestionToPractice done');
//     }
//     if (result is Failure) {
//       debugPrint(result.errorResponse);
//     }
// }
}
