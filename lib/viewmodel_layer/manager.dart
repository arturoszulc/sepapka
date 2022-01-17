import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:sepapka/locator.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/model_layer/services/auth_service.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/question_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts.dart';

class Manager extends ChangeNotifier {
  //Services Injection
  AuthService _authService = serviceLocator.get<AuthService>();
  UserService _userService = serviceLocator.get<UserService>();
  QuestionService _questionService = serviceLocator.get<QuestionService>();
  DatabaseService _databaseService = serviceLocator.get<DatabaseService>();

  //Manager properties
  bool _loading = false;
  String? _errorMsg;

  //Manager getters
  bool get loading => _loading;

  String? get errorMsg => _errorMsg;

  //External Getters
  LoggedUser? get loggedUser => _userService.loggedUser;
  double get progressPercent => _userService.getProgressPercent();
  Question? get currentQuestion => _questionService.currentQuestion;
  QuestionStatus get qStatus => _questionService.qStatus;
  QuestionType get qType => _questionService.qType;
  List<BMap> get bMapList => _questionService.bMapList;

  //if user is signed in, prepare data
  // StreamSubscription<User?> get user =>
  //     _authService.auth.authStateChanges().listen((User? user) {
  //       if (user != null) {
  //         debugPrint('User is logged in');
  //         prepareData(user.uid);
  //       } else {
  //         debugPrint('User is not logged in');
  //         prepareData(null);
  //       }
  //     });

  setError(Failure failure) {
    _errorMsg = failure.errorString;
    debugPrint(_errorMsg);
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  //method deployed by stream automatically
  prepareData(String? userId) async {
    if (loading == false) setLoading(true);
    if (userId == null) {
      await _userService.logOutUser();
    }
    if (userId != null) {
      LoggedUser? userData = await _databaseService.getUserData(userId);
      if (userData == null) return;
      //then create local User instance
      await _userService.createUserLocal(user: userData);
      //prepare questions
      bool qResult = await _questionService.prepareGlobalData();
    }
    setLoading(false);
  }

  signIn({required String email, required String password}) async {
    //start loading app
    setLoading(true);
    //Try to sign in
    Object aResult = await _authService.signInEmail(email, password);
    if (aResult is Failure) {
      setError(aResult);
      setLoading(false);
      return true;
    }
  }

  registerAndPrepareData({required String email, required String password}) async {
    //start loading app
    setLoading(true);
    //register user
    bool result = await _authService.registerWithEmailAndPassword(email, password);
    //if registration succeeded, prepare user and question data
    if (result) {
      bool result = await _questionService.prepareGlobalData();
    }
    // finish loading app
    setLoading(false);
  }

  signOut() async {
    setLoading(true);
    bool result = await _authService.signOut();
    await _userService.logOutUser();
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

  moveQuestionToNew() {}

  //METHODS ON DEMAND ********
  addQuestionsToDb() async {
    for (var question in questionListDB) {
      await _databaseService.uploadQuestions(question);
    }
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
