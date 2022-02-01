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
import 'package:sepapka/utils/question_list.dart';

class Manager extends ChangeNotifier {
  //Services Injection
  AuthService _authService = serviceLocator.get<AuthService>();
  UserService _userService = serviceLocator.get<UserService>();
  QuestionService _questionService = serviceLocator.get<QuestionService>();
  DatabaseService _databaseService = serviceLocator.get<DatabaseService>();

  //Manager properties
  bool _loading = false;

  // bool _newUser = false;
  String? _errorMsg;

  //Manager getters
  bool get loading => _loading;

  // bool get newUser => _newUser;
  String? get errorMsg => _errorMsg;

  //External Getters
  LoggedUser? get loggedUser => _userService.loggedUser;

  double get progressPercentGlobal => _userService.getProgressPercentGlobal();

  int get qNewLeftLevel1 => _userService.loggedUser!.qListNew1.length;

  int get qNewLeftLevel2 => _userService.loggedUser!.qListNew2.length;

  int get qNewLeftLevel3 => _userService.loggedUser!.qListNew3.length;

  bool get isSessionFinished => _questionService.isSessionFinished;

  int get howManyToPracticeToday => _questionService.howManyToPracticeToday();

  double get progressPercentSession => _questionService.getProgressPercentSession();

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
    if (loading == true) setLoading(false);
  }


  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  // methods deployed automatically after user signs in or signs out //
  watchAuthUser() {
    authUser.listen((User? user) async {
      if (user != null) {
        debugPrint('/// User signed in ///');
        await prepareData(user.uid);
      }
      if (user == null) {
        debugPrint('/// User signed out ///');
        await _userService.logOutUser();
      }
      setLoading(false);
    });
  }

  prepareData(String userId) async {
    // keep the app in loading state
    if (loading == false) setLoading(true);

    // download user data and create local user object
    Object createUserResult = await _userService.createUserLocal(userId);
    if (createUserResult is Failure) {
      setError(createUserResult);
      return;
    }

    //next prepare questions
    Object prepareDataResult = await _questionService.prepareGlobalData();
    if (prepareDataResult is Failure) setError(prepareDataResult);
  }

  // methods deployed ON DEMAND

  signIn({required String email, required String password}) async {
    //start loading app
    setLoading(true);
    //Try to sign in
    Object signInResult = await _authService.signInEmail(email, password);
    if (signInResult is Failure) setError(signInResult);
    if (signInResult is Success) setError(null);
  }

  register({required String email, required String password}) async {
    //start loading app
    setLoading(true);
    //register user
    Object registerResult = await _authService.registerWithEmailAndPassword(email, password);
    if (registerResult is Failure) setError(registerResult);
    if (registerResult is Success) setError(null);
  }


  signOut() async {
    bool result = await _authService.signOut();
  }

  resetPassword(String email) async {
    debugPrint('/// manager ResetPassword deployed');
    setLoading(true);
    Object resetPassResult = await _authService.resetPassword(email);
    if (resetPassResult is Failure) setError(resetPassResult);
    if (resetPassResult is Success) setError(null);
  }

  resetUserProgress() async {
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
    notifyListeners();
  }

  moveQuestionToNew() {}

  doNotShowThisQuestionAnymore() {
    debugPrint('/// Pytanie oznaczone jako notShown ///');
  }

  sendQuestionRemarks() {
    debugPrint('/// Przesłano uwagę na temat pytania ///');
  }

  // ******* METHODS ON DEMAND ********

  //Questions for Users
  addQuestionsToDb({required bool isPro}) async {
    debugPrint('/// addQuestionsToDb deployed ///');
    if (!isPro) {
      for (var question in questionListDB) {
        if (question.level == 1) {
          await _databaseService.uploadQuestions(
            question: question, isPro: isPro);
        }
      }
    }
    else {
      for (var question in questionListDB) {
        await _databaseService.uploadQuestions(question: question, isPro: isPro);
      }
    }
  }
}