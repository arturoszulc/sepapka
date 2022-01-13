import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:sepapka/locator.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/model_layer/services/auth_service.dart';
import 'package:sepapka/model_layer/services/question_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/consts.dart';

class Manager extends ChangeNotifier {
  //Services Injection
  AuthService _authService = serviceLocator.get<AuthService>();
  UserService _userService = serviceLocator.get<UserService>();
  QuestionService _questionService = serviceLocator.get<QuestionService>();

  //Manager properties
  bool _loading = false;

  //Manager getters
  bool get loading => _loading;

  //External Getters
  LoggedUser? get loggedUser => _userService.loggedUser;

  Question? get currentQuestion => _questionService.currentQuestion;
  QuestionStatus get qStatus => _questionService.qStatus;
  QuestionType get qType => _questionService.qType;
  List<BMap> get bMapList => _questionService.bMapList;




  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  signInAndPrepareData({required String email, required String password}) async {
    //start loading app
    setLoading(true);
    bool result = await _authService.signInEmail(email, password);

    //if sign in succeeded, prepare and/or update question data
    if (result)
      {
        bool result = await _questionService.prepareGlobalData();
      }
    // finish loading app
    setLoading(false);
  }

  registerAndPrepareData({required String email, required String password}) async {
    //start loading app
    setLoading(true);
    //register user
    bool result = await _authService.registerWithEmailAndPassword(email, password);
    //if registration succeeded, prepare user and question data
    if (result)
    {
      bool result = await _questionService.prepareGlobalData();
    }
    // finish loading app
    setLoading(false);

  }

  signOut() async {
    setLoading(true);
    bool result = await _authService.signOut();
    setLoading(false);
  }

  checkAnswer(String answer) async {
    ///TODO: LOCK POSSIBILITY OF PUSHING ANOTHER BUTTON BEFORE ANSWER IS CHECKED
    await _questionService.checkAnswer(answer);
    notifyListeners();
  }
  prepareQuestion(QuestionType qType) async {
    await _questionService.prepareQuestion(qType);
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
