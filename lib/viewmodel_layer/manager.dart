import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; //iconData is from here
import 'package:sepapka/locator.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/model_layer/models/rank_user.dart';
import 'package:sepapka/model_layer/services/auth_service.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/question_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/utils/consts/question.dart';
import 'package:sepapka/utils/question_list.dart';

class Manager extends ChangeNotifier {
  //Services Injection
  AuthService _authService = serviceLocator.get<AuthService>();
  UserService _userService = serviceLocator.get<UserService>();
  QuestionService _questionService = serviceLocator.get<QuestionService>();
  DatabaseService _databaseService = serviceLocator.get<DatabaseService>();

  //Manager properties
  bool _loading = false;

  String _errorMsg = '';
  String _infoMsg = '';

  Screen _currentScreen = Screen.loading;

  //Manager getters
  bool get loading => _loading;

  Screen get currentScreen => _currentScreen;

  // bool get newUser => _newUser;
  String get errorMsg => _errorMsg;

  String get infoMsg => _infoMsg;

  //External Getters

  //UserService
  LoggedUser? get loggedUser => _userService.loggedUser;

  String get progressPercentGlobal => _userService.getProgressPercentGlobal();

  int get qNewLeftLevel1 => _userService.loggedUser!.qListNew1.length;

  int get qNewLeftLevel2 => _userService.loggedUser!.qListNew2.length;

  int get qNewLeftLevel3 => _userService.loggedUser!.qListNew3.length;

  bool get isSessionFinished => _questionService.isSessionFinished;

  bool get isUserPromoted => _userService.isUserPromoted;

  String get userRankName => _userService.userRankName;

  //Question Service

  int get howManyToPracticeToday => _questionService.howManyToPracticeToday();

  double get progressPercentSession => _questionService.getProgressPercentSession();

  Question? get currentQuestion => _questionService.currentQuestion;

  QuestionStatus get qStatus => _questionService.qStatus;

  QuestionType get qType => _questionService.qType;

  QuestionFilter get qFilter => _questionService.qFilter;

  List<BMap> get bMapList => _questionService.bMapList;

  List<Question> get qListGlobalFiltered => _questionService.qListGlobalFiltered;

  //AuthService

  Stream<User?> get authUser => _authService.auth.authStateChanges();

  //DatabaseService
  Stream<List<RankUser>> get userRankTop => _databaseService.usersRankTop;

  Stream<List<RankUser>?> get userRankUser => _databaseService.userRankUser;

  Manager() {
    //on initialize, subscribe to stream that checks if user is logged in or not
    watchAuthUser();
  }

  // internal Manager methods affecting UI

  navigate(Screen screen) {
    debugPrint('NAVIGATING to: $screen');
    _currentScreen = screen;
    // if (errorMsg.isNotEmpty) setError(null);
    notifyListeners();
  }

  setError(Failure? failure) {
    if (failure == null) {
      _errorMsg = '';
      return;
    } else {
      _errorMsg = failure.errorString!;
      debugPrint('setError debugPrint: $_errorMsg');
      notifyListeners();
    }
  }

  setMessage(String msg) {
    _infoMsg = msg;
  }

  setLoading(bool loading) async {
    debugPrint('/// setLoading deployed ///');
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
        if (_currentScreen != Screen.signIn) navigate(Screen.signIn);
      }
    });
  }

  prepareData(String userId) async {
    // keep the app in loading state
    if (_currentScreen != Screen.loading) navigate(Screen.loading);

    // download user data and create local user object
    Object createUserResult = await _userService.createUserLocal(userId);
    if (createUserResult is Failure) {
      setError(createUserResult);
      navigate(Screen.signIn);
      return;
    }

    //next prepare questions
    Object prepareDataResult = await _questionService.prepareGlobalData();
    if (prepareDataResult is Failure) {
      setError(prepareDataResult);
      navigate(Screen.signIn);
      return;
    }
    navigate(Screen.menu);
  }

  ////////////////////////
  // METHODS ON DEMAND  //
  ////////////////////////

  // AUTH

  signIn({required String email, required String password}) async {
    //start loading app
    navigate(Screen.loading);
    // setLoading(true);
    //Try to sign in
    Object signInResult = await _authService.signInEmail(email, password);
    if (signInResult is Failure) {
      setError(signInResult);
      navigate(Screen.signIn);
    }
    if (signInResult is Success) setError(null);
  }

  register({required String email, required String password}) async {
    //start loading app
    navigate(Screen.loading);
    //register user
    Object registerResult = await _authService.registerWithEmailAndPassword(email, password);
    if (registerResult is Failure) {
      setError(registerResult);
      navigate(Screen.signIn);
    }
    if (registerResult is Success) setError(null);
  }

  signInWithGoogle() async {
    Object signInGoogleResunt = await _authService.signInGoogle();
    if (signInGoogleResunt is Failure) {
      setError(signInGoogleResunt);
      navigate(Screen.signIn);
    }
    if (signInGoogleResunt is Success) setError(null);
  }

  signOut() async {
    Object signOutResult = await _authService.signOut();
    if (signOutResult is Failure) {
      setError(signOutResult);
      navigate(Screen.settings);
    }
    navigate(Screen.signIn);
  }

  resetPassword(String email) async {
    debugPrint('/// manager ResetPassword deployed');
    navigate(Screen.loading);
    //TODO: uncomment the _authService method
    Object resetPassResult =
        Failure('Cos poszlo nie tak'); //await _authService.resetPassword(email);
    if (resetPassResult is Failure) {
      await setError(resetPassResult);
      navigate(Screen.resetPassword);
    }
    if (resetPassResult is Success) {
      await setError(null);
      // setLoading(true);
      setMessage('Link do zresetowania hasła został wysłany na podany adres e-mail');
      navigate(Screen.signIn);
    }
  }

  // USER

  resetUserProgress() async {
    navigate(Screen.loading);
    Object resetResult = await _questionService.resetUserProgress();
    if (resetResult is Failure) {
      setError(resetResult);
      return;
    }
    setMessage('Wszelkie postępy zostały skasowane');
    navigate(Screen.menu);
  }

  resetIsUserPromotedFLag() {
    _userService.setIsUserPromoted(false);
  }

  goPro(bool bool) async {
    navigate(Screen.loading);
    //change user property and reset qVersion (in order to re-download questions from DB
    Object goProResult = await _userService.goPro(bool);
    if (goProResult is Failure) {
      setError(goProResult);
      navigate(Screen.settings);
      return;
    }
    //prepare new global data
    Object prepareDataResult = await _questionService.prepareGlobalData();
    if (prepareDataResult is Failure) {
      setError(prepareDataResult);
      navigate(Screen.settings);
      return;
    }
    navigate(Screen.menu);
  }

  updateUserData(String username) async {
    navigate(Screen.loading);
    Object changeUsernameResult = await _userService.changeUserName(username);
    if (changeUsernameResult is Failure) {
      setError(changeUsernameResult);
      navigate(Screen.changeUserName);
      return;
    }
    if (changeUsernameResult is Success) {
      setError(null);
      navigate(Screen.settings);
      return;
    }
  }

  // QUESTIONS

  checkAnswer(String answer) async {
    ///TODO: LOCK POSSIBILITY OF PUSHING ANOTHER BUTTON BEFORE ANSWER IS CHECKED
    await _questionService.checkAnswer(answer);
    notifyListeners();
  }

  startNew({required int qLevel}) async {
    await _questionService.prepareCurrentSessionData(
        qType: QuestionType.newQuestion, qLevel: qLevel);
    await getNextQuestion();
    navigate(Screen.singleQuestion);
  }

  startPractice() async {
    await _questionService.prepareCurrentSessionData(
        qType: QuestionType.practiceQuestion, qLevel: 0);
    await getNextQuestion();
    navigate(Screen.singleQuestion);
  }

  getNextQuestion() async {
    Object nextQuestionResult = await _questionService.getNextQuestion();
    if (nextQuestionResult is Success) {
      notifyListeners();
    };
    if (nextQuestionResult is Failure) {
      //if failure, then no more questions left. End session.
      Object endResult = await _questionService.endSession();
      if (endResult is Failure) {
        setMessage(endResult.errorString.toString());
        return;
      }
      navigate(Screen.sessionFinished);
    }
  }

  interruptSession() async {
    //if session was interrupted, download user again
    Object interruptResult = _userService.rollUserBack();
    if (interruptResult is Failure) {
      setMessage(interruptResult.errorString.toString());
    }
    navigate(Screen.menu);
  }

  moveQuestionToNew() {}

  doNotShowThisQuestionAnymore() {
    _questionService.doNotShowThisQuestionAnymore();
    getNextQuestion();
  }

  sendQuestionRemark(String remark) async {
    debugPrint('sendQuestionRemark deployed');
    Object sendResult = await _questionService.sendQuestionRemark(remark);
    if (sendResult is Failure) {
      setError(sendResult);
      navigate(Screen.remark);
    } else {
      setError(null);
      debugPrint('/// Przesłano uwagę na temat pytania ///');
      setMessage('Dziękuję za przesłanie uwagi!');
      navigate(Screen.singleQuestion);
    }
  }

  // ******* METHODS ON DEMAND ********

  //Questions for Users
  addQuestionsToDb({required bool isPro}) async {
    debugPrint('/// addQuestionsToDb deployed ///');
    if (!isPro) {
      for (var question in questionListDB) {
        if (question.level == 1) {
          await _databaseService.uploadQuestions(question: question, isPro: isPro);
        }
      }
    } else {
      for (var question in questionListDB) {
        await _databaseService.uploadQuestions(question: question, isPro: isPro);
      }
    }
  }

  getFilteredQuestionList({QuestionFilter? filter}) {
    if (filter == qFilter) return;
    navigate(Screen.loading);
    filter ??= QuestionFilter.alphabetical;
    _questionService.getFilteredQuestionList(filter);
    navigate(Screen.listQuestion);
  }

  Widget getQuestionIcon(String qId) {
    return _userService.getQListIcon(qId);
  }
}
