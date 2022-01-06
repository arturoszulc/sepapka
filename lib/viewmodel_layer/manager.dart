import 'package:flutter/foundation.dart';
import 'package:sepapka/locator.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/question.dart';
import 'package:sepapka/model_layer/services/auth.dart';
import 'package:sepapka/model_layer/services/question.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';

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
  Question? get singleKnownQuestion => _questionService.singleKnownQuestion;



  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  signIn({required String email, required String password}) async {
    setLoading(true);
    var result = await _authService.signInEmail(email, password);
    // var result = await UserService.getUser(email, password);
    if (result is Success) {
      debugPrint('Manager.signIn() SUCCESS response: ${result.response}');
    }
    if (result is Failure) {
      debugPrint('Manager.signIn() failure response: ${result.errorResponse}');
    }
    setLoading(false);
  }

  prepareSingleQuestion() async {
    await _questionService.prepareKnownQuestion();
  }

  moveQuestionToPractice(String questionId) async {
    await _questionService.moveQuestionToPractice(questionId);
}
}
