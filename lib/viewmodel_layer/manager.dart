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

  Stream<User?> get authUser => _authService.auth.authStateChanges();

  Manager() {
    //on initialize, subscribe to stream that checks if user is logged in or not
    watchAuthUser();
  }

  // internal Manager methods affecting UI
  setError(Failure? failure) {
    if (failure == null) {
      _errorMsg = null;
      return;
    }
    _errorMsg = failure.errorString;
    debugPrint(_errorMsg);
    // if (loading == false) setLoading(true);
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  // methods deployed automatically after user signs in or signs out //
  watchAuthUser() {
    authUser.listen((User? user) {
      if (user != null) {
        debugPrint('/// User signed in ///');
        prepareData(user.uid);
      }
      if (user == null) {
        debugPrint('/// User signed out ///');
        _userService.logOutUser();
        notifyListeners();
      }
    });
  }

  prepareData(String userId) async {
    // keep the app in loading state
    if (loading == false) setLoading(true);

    // download user data and create local user object
    Object createUserResult = await _userService.createUserLocal(userId);
    if (createUserResult is Failure) {
      setError(createUserResult);
      setLoading(false);
      return;
    }
    //prepare questions
    Object prepareDataResult = await _questionService.prepareGlobalData();
    if (prepareDataResult is Failure) setError(prepareDataResult);
    setLoading(false);
  }

  // methods deployed ON DEMAND

  signIn({required String email, required String password}) async {
    //start loading app
    setLoading(true);
    //Try to sign in
    Object signInResult = await _authService.signInEmail(email, password);
    if (signInResult is Failure) setError(signInResult);
    if (signInResult is Success) setError(null);
    setLoading(false);
  }

  register({required String email, required String password}) async {
    //start loading app
    setLoading(true);
    //register user
    Object registerResult = await _authService.registerWithEmailAndPassword(email, password);
    if (registerResult is Failure) setError(registerResult);
  }

  signOut() async {
    bool result = await _authService.signOut();
  }

  resetUserProgress() async {
    debugPrint('ResetUserProgress deployed');

    Object resetResult = _questionService.resetUserProgress();
    if (resetResult is Failure) setError(resetResult);
  }

  checkAnswer(String answer) async {
    ///TODO: LOCK POSSIBILITY OF PUSHING ANOTHER BUTTON BEFORE ANSWER IS CHECKED
    await _questionService.checkAnswer(answer);
    notifyListeners();
  }

  startNew({required int qLevel}) async {
    await _questionService.prepareCurrentSessionData(
        qType: QuestionType.newQuestion, qLevel: qLevel);
    await getNextQuestion();
  }

  startPractice() async {
    await _questionService.prepareCurrentSessionData(
        qType: QuestionType.practiceQuestion, qLevel: 0);
    await getNextQuestion();
  }

  getNextQuestion() async {
    await _questionService.getNextQuestion();
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
