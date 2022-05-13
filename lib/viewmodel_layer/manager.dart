import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; //iconData is from here
import 'package:sepapka/locator.dart';
import 'package:sepapka/model_layer/models/button_map.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:sepapka/model_layer/models/validation.dart';
import 'package:sepapka/model_layer/services/auth_service.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/purchase_service.dart';
import 'package:sepapka/model_layer/services/question_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/model_layer/services/validation_service.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts/errors_messages.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/utils/consts/question.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Manager extends ChangeNotifier {
  //Services Injection
  AuthService _authService = serviceLocator.get<AuthService>();
  UserService _userService = serviceLocator.get<UserService>();
  QuestionService _questionService = serviceLocator.get<QuestionService>();
  DatabaseService _databaseService = serviceLocator.get<DatabaseService>();
  ValidationService _validationService = serviceLocator.get<ValidationService>();
  PurchaseService _purchaseService = serviceLocator.get<PurchaseService>();

  //Manager properties
  bool _loading = false;

  int qListGlobalFilteredIndex = 0;

  String _errorMsg = '';
  String _infoMsg = '';
  String appVersion = '';

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

  int get qNewLeft => _userService.loggedUser!.qListNew.length;

  bool get isSessionFinished => _questionService.isSessionFinished;

  // String get userRankName => _userService.userRankName;

  //Question Service

  double get progressPercentSession => _questionService.getProgressPercentSession();

  String get userScore => _questionService.getUserScore();

  Question? get currentQuestion => _questionService.currentQuestion;

  QuestionStatus get qStatus => _questionService.qStatus;

  int get filterType => _questionService.filterType;

  int get filterLevel => _questionService.filterLevel;

  int get filterCategory => _questionService.filterCategory;

  List<BMap> get bMapList => _questionService.bMapList;

  List<Question> get qListGlobalFiltered => _questionService.qListGlobalFiltered;


  List<int> get countQuestionsByLevel => _questionService.countQuestionsByLevel();

  List<int> get countQuestionsByCategories => _questionService.countQuestionsByCategory();

  //AuthService

  Stream<User?> get authUser => _authService.auth.authStateChanges();

  //DatabaseService
  // Stream<List<RankUser>> get userRankTop => _databaseService.usersRankTop;

  // Stream<List<RankUser>?> get userRankUser => _databaseService.userRankUser;


  //ValidationService
  ValidationModel get email => _validationService.email;
  ValidationModel get emailRemind => _validationService.emailRemind;
  ValidationModel get password => _validationService.password;
  ValidationModel get remark => _validationService.remark;
  bool get isEmailAndPasswordValid => _validationService.isEmailAndPasswordValid;


  Manager() {
    //get app version
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appVersion = packageInfo.version;
    });

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
  hideError(){
    _errorMsg = '';
    notifyListeners();
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
  //        AUTH        //
  ////////////////////////


  signIn({required String email, required String password}) async {
    //start loading app
    navigate(Screen.loading);
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
    if (registerResult is Success) {
      setError(null);
    }
  }

  signInWithGoogle() async {
    Object signInGoogleResult = await _authService.signInGoogle();
    if (signInGoogleResult is Failure) {
      setError(signInGoogleResult);
      navigate(Screen.signIn);
    }
    if (signInGoogleResult is Success) setError(null);
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
    Object resetPassResult = await _authService.resetPassword(email);
    if (resetPassResult is Failure) {
      await setError(resetPassResult);
      navigate(Screen.resetPassword);
    }
    if (resetPassResult is Success) {
      await setError(null);
      // setLoading(true);
      setMessage(msgResetSent);
      navigate(Screen.signIn);
    }
  }

  ////////////////////////
  //        USER        //
  ////////////////////////

  goPro() async {
    Object goProResult = await _userService.goPro();
    if (goProResult is Failure) {
      setError(goProResult);
      return;
    }
    //prepare new global data
    Object prepareDataResult = await _questionService.prepareGlobalData();
    if (prepareDataResult is Failure) {
      setError(prepareDataResult);
      return;
    }
    navigate(Screen.purchaseSuccess);
  }

  ////////////////////////
  //     QUESTIONS      //
  ////////////////////////


  chooseQuestionLevel(int level) async {
    await _questionService.setQuestionLevel(level);
    //after choosing Level, choose category
    navigate(Screen.chooseCategory);
  }

  chooseQuestionCategory(int catNumber) {
    _questionService.setQuestionCategory(catNumber);
    //after choosing Category, prepare Session Data
    startSession();
  }

  startSession() async {
    await _questionService.prepareSession();
    getNextQuizQuestion();
  }

  checkAnswer(String answer) async {
    ///TODO: LOCK POSSIBILITY OF PUSHING ANOTHER BUTTON BEFORE ANSWER IS CHECKED
    await _questionService.checkAnswer(answer);
    notifyListeners();
  }

  getNextQuizQuestion() async {
    Object nextQuestionResult = await _questionService.getNextQuestion();
    if (nextQuestionResult is Success) {
      navigate(Screen.quizQuestionSingle);
    }
    if (nextQuestionResult is Failure) {
      //if failure, then no more questions left. End session.
      Object endResult = _questionService.endSession();
      if (endResult is Failure) {
        setMessage(endResult.errorString.toString());
        return;
      }
      navigate(Screen.sessionFinished);
    }
  }

  interruptSession() async {
    navigate(Screen.menu);
  }

  moveQuestionBackToShown() async {
    debugPrint('moveQuestionBackToShown deployed');
    await _userService.moveQMapToNew(qListGlobalFiltered[qListGlobalFilteredIndex].id);
    _userService.updateLoggedUserInDb();
    //this method is available only in Question List Screen, so you always have to update
    //filtered question list
    await _questionService.getFilteredQuestionList();
    if (qListGlobalFilteredIndex == qListGlobalFiltered.length && qListGlobalFilteredIndex > 0) {
      qListGlobalFilteredIndex -= 1;
    }
    showSingleFilteredQuestion(qListGlobalFilteredIndex);
  }

  doNotShowThisQuestionAnymore() async {
    debugPrint('doNotShowThisQuestionAnymore() deployed');

    //there are two use cases
    //1. User calls this method during quiz
    if (_currentScreen == Screen.quizQuestionSingle) {
      await _userService.moveQMapToNotShown(currentQuestion!.id);
      _userService.updateLoggedUserInDb();
      _questionService.removeCurrentQuestionFromSession();
      getNextQuizQuestion();
    }
    //2. User calls this method during question list
    if (_currentScreen == Screen.listQuestionSingle) {
      await _userService.moveQMapToNotShown(qListGlobalFiltered[qListGlobalFilteredIndex].id);
      _userService.updateLoggedUserInDb();
      await _questionService.getFilteredQuestionList();
      if (qListGlobalFilteredIndex == qListGlobalFiltered.length && qListGlobalFilteredIndex > 0) {
        debugPrint('Entered IF loop');
        qListGlobalFilteredIndex -= 1;
      }
      showSingleFilteredQuestion(qListGlobalFilteredIndex);
    }
  }

  bool isQuestionHidden(String? qId) {
    if (qId == null) return false;
    var result = _userService.isQuestionInNotShownList(qId);
    if (result == null) return false;
    return true;
  }

  setListFilter({int? fType, int? fLevel, int? fCategory}) {
    if (fType != null) {
      debugPrint('fType: $fType');
      _questionService.filterType = fType;
      // _questionService.filterTypeChanged = true;
    }
    if (fLevel != null) {
      debugPrint('fLevel: $fLevel');
      _questionService.filterLevel = fLevel;
      // _questionService.filterLevelChanged = true;
    }
    if (fCategory != null) {
      debugPrint('fCategory: $fCategory');
      _questionService.filterCategory = fCategory;
      // _questionService.filterCategoryChanged = true;
    }
  }

  getFilteredQuestionList() async {
    navigate(Screen.loading);
    await _questionService.getFilteredQuestionList();
    navigate(Screen.listQuestion);
  }

  Question? getSingleFilteredQuestion() {
    if (qListGlobalFiltered.isEmpty) return null;
    return qListGlobalFiltered[qListGlobalFilteredIndex];
  }

  showSingleFilteredQuestion(int index) {
    debugPrint('Entered showSingleFilteredQuestion');
    //update index
    qListGlobalFilteredIndex = index;
    //update question

    //update isQuestionHidden
    if (qListGlobalFiltered.isEmpty) {
      debugPrint('QListGlobalFiltered IS EMPTY');
      navigate(Screen.listQuestion);
    } else {
      //refresh screen
      navigate(Screen.listQuestionSingle);
    }
  }

  sendQuestionRemark() async {
    Object sendResult = await _questionService.sendQuestionRemark(remark.value!, appVersion);
    if (sendResult is Failure) {
      setError(sendResult);
      navigate(Screen.remark);
    } else {
      setError(null);
      setMessage(msgThanksForRemark);
      navigate(Screen.quizQuestionSingle);
    }
  }

  ////////////////////////
  //     VALIDATION     //
  ////////////////////////

  void validateEmail(String val) {
    _validationService.validateEmail(val);
    notifyListeners();
  }
  void validatePassword(String val) {
    _validationService.validatePassword(val);
    notifyListeners();
  }
  void validateEmailRemind(String val) {
    _validationService.validateEmailRemind(val);
    notifyListeners();
  }
  void validateRemark(String val) {
    _validationService.validateRemark(val);
    notifyListeners();
  }

  ////////////////////////
  //      PURCHASE      //
  ////////////////////////


  revenueCatStart() async {
    await _purchaseService.init();
    await _purchaseService.getOffers();
  }


  // bool get isAvailable => _purchaseService.isStoreAvailable;
  // String get productName => _purchaseService.productName;
  // String get productPrice => _purchaseService.productPrice;
  // PurchaseStatus? get purchaseStatus => _purchaseService.purchaseDetails?.status;
  // Stream<bool> get hasPurchased => _purchaseService.purchaseStream;
  // StreamSubscription<bool>? purchaseListener;


  // openStore() async {
  //   debugPrint('*** Opening Store ***');
  //   Object initializeResult = await _purchaseService.initialize();
  //   if (initializeResult is Failure) {
  //     debugPrint(initializeResult.errorString);
  //     navigate(Screen.purchaseError);
  //     return;
  //   }
  //   listenStore();
  //   if (purchaseStatus != null && purchaseStatus == PurchaseStatus.pending) {
  //     navigate(Screen.purchasePending);
  //   } else {
  //     navigate(Screen.purchase);
  //   }
  // }
  //
  // listenStore() {
  //   purchaseListener = hasPurchased.listen((purchaseCompleted) async {
  //     if (purchaseCompleted) {
  //       navigate(Screen.loading);
  //       debugPrint('&&&& PURCHASE COMPLETED &&&&');
  //       _databaseService.savePurchaseDetails(_purchaseService.purchaseDetails!, loggedUser!.documentId);
  //       await closeStore();
  //       await goPro();
  //       navigate(Screen.purchaseSuccess);
  //     }
  //   }, onError: ((_) {
  //     debugPrint('purchaseListener ERROR');
  //     navigate(Screen.purchaseError);
  //   }),);
  // }
  //
  // closeStore() async {
  //   debugPrint('*** closing store... ***');
  //   await purchaseListener!.cancel();
  //   _purchaseService.closeStore();
  // }
  //
  // getUserProducts() async {
  //   await _purchaseService.getUserProducts();
  //   notifyListeners();
  // }
  //
  // buyProduct() {
  //   _purchaseService.buyProduct();
  // }



  Widget getQuestionIcon(String qId) {
    return _userService.getQListIcon(qId);
  }



// String getBadgePath({int? rankLevel}) {
//   String badge = '0';
//   //if rank level is not given, return loggedUser badge
//   if (rankLevel == null) badge = loggedUser!.rankLevel.toString();
//   //if rankLevel is given, return corresponding badge
//   if (rankLevel != null) badge = rankLevel.toString();
//   return 'assets/images/badges/$badge.png';
// }
}
