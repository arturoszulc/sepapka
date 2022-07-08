// import 'dart:async';
// import 'dart:developer';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:purchases_flutter/errors.dart';
// import 'package:purchases_flutter/models/entitlement_info_wrapper.dart';
// import 'package:purchases_flutter/models/product_wrapper.dart';
// import 'package:sepapka/trash/locator.dart';
// import 'package:sepapka/models/logged_user.dart';
// import 'package:sepapka/models/question.dart';
// import 'package:sepapka/models/input_validation_model.dart';
// import 'package:sepapka/services/auth_service.dart';
// import 'package:sepapka/services/purchase_service.dart';
// import 'package:sepapka/services/quiz_service.dart';
// import 'package:sepapka/services/user_service.dart';
// import 'package:sepapka/services/validation_service.dart';
// import 'package:sepapka/utils/api_status.dart';
// import 'package:sepapka/utils/consts/my_screens.dart';
// import 'package:sepapka/utils/consts/question.dart';
//
//
//
//
// final manager = ChangeNotifierProvider<Manager>((ref) {
//   return Manager(ref);
// });
//
// class Manager extends ChangeNotifier {
//   final Ref _ref;
//
//   Manager(this._ref) {
//     log('^^^ Manager initialized ^^^');
//     //on initialize, subscribe to stream that checks if user is logged in or not
//     // watchAuthUser();
//   }
//
//
//
//
//   //Services Injection
//   // AuthService _authService = serviceLocator.get<AuthService>();
//   // UserService _userService = serviceLocator.get<UserService>();
//   // QuizService _questionService = serviceLocator.get<QuizService>();
//   // DatabaseService _databaseService = serviceLocator.get<DatabaseService>();
//   // ValidationService _validationService = serviceLocator.get<ValidationService>();
//   // PurchaseService _purchaseService = serviceLocator.get<PurchaseService>();
//   // RouteService _routeService = serviceLocator.get<RouteService>();
//
//   //Manager properties
//   bool _loading = false;
//
//   int qListGlobalFilteredIndex = 0;
//
//   String _errorMsg = '';
//   String _infoMsg = '';
//
//   final MyScreen  _currentScreen = MyScreen.loading;
//
//   //Manager getters
//   bool get loading => _loading;
//
//   MyScreen get currentScreen => _currentScreen;
//
//   // bool get newUser => _newUser;
//   String get errorMsg => _errorMsg;
//
//   String get infoMsg => _infoMsg;
//
//   //External Getters
//
//
//
//
//   //Question Service
//
//   double get progressPercentSession => 0.0;//_questionService.getProgressPercentSession();
//
//   // String get userScore => _ref.read(quizService).getUserScore();
//
//   // Question? get currentQuestion => _questionService.currentQuestion;
//
//   // QuestionStatus get qStatus => QuestionStatus.noAnswer;//_questionService.qStatus;
//
//   // List<Question> get qListGlobalFiltered => [];//_questionService.qListGlobalFiltered;
//
//   // List<int> get countQuestionsByLevel => _questionService.countQuestionsByLevel();
//
//   // List<int> get countQuestionsByCategories => _questionService.countQuestionsByCategory();
//
//
//   //DatabaseService
//   // Stream<List<RankUser>> get userRankTop => _databaseService.usersRankTop;
//
//   // Stream<List<RankUser>?> get userRankUser => _databaseService.userRankUser;
//
//   //ValidationService
//   // ValidationModel get email => _validationService.email;
//
//   // InputValidationModel get emailRemind => _ref.read(validationService).emailRemind;
//
//   // InputValidationModel get password => _ref.read(validationService).password;
//
//   // InputValidationModel get remark => _ref.read(validationService).remark;
//
//   // bool get isEmailAndPasswordValid => _validationService.isEmailAndPasswordValid;
//
//
//
//   // internal Manager methods affecting UI
//
//
//
//   setError(Failure? failure) {
//     if (failure == null) {
//       _errorMsg = '';
//       notifyListeners();
//       return;
//     } else {
//       _errorMsg = failure.errorString!;
//       debugPrint('setError debugPrint: $_errorMsg');
//       notifyListeners();
//     }
//   }
//
//   setMessage(String msg) {
//     _infoMsg = msg;
//   }
//
//   setLoading(bool loading) async {
//     debugPrint('/// setLoading deployed ///');
//     _loading = loading;
//     notifyListeners();
//   }
//
//   // methods deployed automatically after user signs in or signs out //
//   // watchAuthUser() {
//   //   authUser.listen((User? user) async {
//   //     if (user != null) {
//   //       log('/// User signed in ///');
//   //       await prepareData(user.uid);
//   //     }
//   //     if (user == null) {
//   //       log('/// User signed out ///');
//   //       // await _userService.logOutUser();
//   //       if (_currentScreen != MyScreen.signIn) navigate(MyScreen.signIn);
//   //     }
//   //   });
//   // }
//
//   // prepareData(String userId) async {
//   //   // keep the app in loading state
//   //   if (_currentScreen != MyScreen.loading) navigate(MyScreen.loading);
//   //
//   //   // download user data and create local user object
//   //   // Object createUserResult = await _userService.createUserLocal(userId);
//   //   // if (createUserResult is Failure) {
//   //   //   setError(createUserResult);
//   //   //   navigate(MyScreen.signIn);
//   //   //   return;
//   //   // }
//   //
//   //   //next prepare questions
//   //   // Object prepareDataResult = await _questionService.prepareGlobalData();
//   //   // if (prepareDataResult is Failure) {
//   //   //   setError(prepareDataResult);
//   //   //   navigate(MyScreen.signIn);
//   //   //   return;
//   //   // }
//   //   //reset data entered in sign in screen forms
//   //   // email.value = null;
//   //   // password.value = null;
//   //   navigate(MyScreen.menu);
//   // }
//
//   ////////////////////////
//   //        AUTH        //
//   ////////////////////////
//
//   Stream<User?> get authUser => _ref.watch(authStateProvider.stream);
//
//
//   // signIn({required String email, required String password}) async {
//   //   //start loading app
//   //   navigate(MyScreen.loading);
//   //   //Try to sign in
//   //   Object signInResult = await _authService.signInEmail(email.toLowerCase(), password);
//   //   if (signInResult is Failure) {
//   //     setError(signInResult);
//   //     navigate(MyScreen.signIn);
//   //   }
//   //   if (signInResult is Success) setError(null);
//   // }
//   //
//   // register({required String email, required String password}) async {
//   //   //start loading app
//   //   navigate(MyScreen.loading);
//   //   //register user
//   //   Object registerResult =
//   //       await _authService.registerWithEmailAndPassword(email.toLowerCase(), password);
//   //   if (registerResult is Failure) {
//   //     setError(registerResult);
//   //     navigate(MyScreen.signIn);
//   //   }
//   //   if (registerResult is Success) {
//   //     setError(null);
//   //   }
//   // }
//   //
//   // signInWithGoogle() async {
//   //   Object signInGoogleResult = await _authService.signInGoogle();
//   //   if (signInGoogleResult is Failure) {
//   //     setError(signInGoogleResult);
//   //     navigate(MyScreen.signIn);
//   //   }
//   //   if (signInGoogleResult is Success) setError(null);
//   // }
//   //
//   // signOut() async {
//   //   Object signOutResult = await _authService.signOut();
//   //   if (signOutResult is Failure) {
//   //     setError(signOutResult);
//   //     navigate(MyScreen.settings);
//   //   }
//   //   navigate(MyScreen.signIn);
//   // }
//
//   // resetPassword(String email) async {
//   //   debugPrint('/// manager ResetPassword deployed');
//   //   navigate(MyScreen.loading);
//   //   // Object resetPassResult = await _authService.resetPassword(email.toLowerCase());
//   //   // if (resetPassResult is Failure) {
//   //   //   await setError(resetPassResult);
//   //   //   navigate(MyScreen.resetPassword);
//   //   // }
//   //   // if (resetPassResult is Success) {
//   //   //   await setError(null);
//   //   //   setLoading(true);
//   //   //   setMessage(msgResetSent);
//   //   //   navigate(MyScreen.signIn);
//   //   // }
//   // }
//
//   ////////////////////////
//   //        USER        //
//   ////////////////////////
//
//   // LoggedUser? get loggedUser => _ref.read(userService.notifier).loggedUser;
//
//   // int get qNewLeft => _userService.loggedUser!.qListNew.length;
//
//   // bool get isSessionFinished => _ref.read(quizService).isSessionFinished;
//
//   // goPro() async {
//   //   // Object goProResult = await _userService.goPro();
//   //   // if (goProResult is Failure) {
//   //   //   setError(goProResult);
//   //   //   return;
//   //   // }
//   //   //prepare new global data
//   //   // Object prepareDataResult = await _questionService.prepareGlobalData();
//   //   // if (prepareDataResult is Failure) {
//   //   //   setError(prepareDataResult);
//   //   //   return;
//   //   // }
//   //   // navigate(MyScreen.purchaseSuccess);
//   // }
//
//   ////////////////////////
//   //     QUESTIONS      //
//   ////////////////////////
//
//
//
//
//   moveQuestionBackToShown() async {
//     debugPrint('moveQuestionBackToShown deployed');
//     // await _userService.moveQMapToNew(qListGlobalFiltered[qListGlobalFilteredIndex].id);
//     // _userService.updateLoggedUserInDb();
//     // //this method is available only in Question List Screen, so you always have to update
//     // //filtered question list
//     // await _questionService.getFilteredQuestionList();
//     // if (qListGlobalFilteredIndex == qListGlobalFiltered.length && qListGlobalFilteredIndex > 0) {
//     //   qListGlobalFilteredIndex -= 1;
//     // }
//     // showSingleFilteredQuestion(qListGlobalFilteredIndex);
//   }
//
//   doNotShowThisQuestionAnymore() async {
//     debugPrint('doNotShowThisQuestionAnymore() deployed');
//     //
//     // //there are two use cases
//     // //1. User calls this method during quiz
//     // if (_currentScreen == MyScreen.quizQuestionSingle) {
//     //   await _userService.moveQMapToNotShown(currentQuestion!.id);
//     //   await _userService.updateLoggedUserInDb();
//     //   _questionService.removeCurrentQuestionFromSession();
//     //   getNextQuizQuestion();
//     // }
//     // //2. User calls this method during question list
//     // if (_currentScreen == MyScreen.listQuestionSingle) {
//     //   await _userService.moveQMapToNotShown(qListGlobalFiltered[qListGlobalFilteredIndex].id);
//     //   _userService.updateLoggedUserInDb();
//     //   await _questionService.getFilteredQuestionList();
//     //   if (qListGlobalFilteredIndex == qListGlobalFiltered.length && qListGlobalFilteredIndex > 0) {
//     //     debugPrint('Entered IF loop');
//     //     qListGlobalFilteredIndex -= 1;
//     //   }
//     //   showSingleFilteredQuestion(qListGlobalFilteredIndex);
//     // }
//   }
//
//   bool isQuestionHidden(String? qId) {
//     if (qId == null) return false;
//     // var result = _userService.isQuestionInNotShownList(qId);
//     // if (result == null) return false;
//     return true;
//   }
//
//   // setListFilter({int? fType, int? fLevel, int? fCategory}) {
//   //   if (fType != null) {
//   //     debugPrint('fType: $fType');
//   //     _questionService.filterType = fType;
//   //     // _questionService.filterTypeChanged = true;
//   //   }
//   //   if (fLevel != null) {
//   //     debugPrint('fLevel: $fLevel');
//   //     _questionService.filterLevel = fLevel;
//   //     // _questionService.filterLevelChanged = true;
//   //   }
//   //   if (fCategory != null) {
//   //     debugPrint('fCategory: $fCategory');
//   //     _questionService.filterCategory = fCategory;
//   //     // _questionService.filterCategoryChanged = true;
//   //   }
//   // }
//
//   getFilteredQuestionList() async {
//     // navigate(MyScreen.loading);
//     // await _questionService.getFilteredQuestionList();
//     // navigate(MyScreen.listQuestion);
//   }
//
//   // Question? getSingleFilteredQuestion() {
//   //   // if (qListGlobalFiltered.isEmpty) return null;
//   //   // return qListGlobalFiltered[qListGlobalFilteredIndex];
//   // }
//
//   // showSingleFilteredQuestion(int index) {
//   //   debugPrint('Entered showSingleFilteredQuestion');
//   //   //update index
//   //   qListGlobalFilteredIndex = index;
//   //   //update question
//   //
//   //   //update isQuestionHidden
//   //   if (qListGlobalFiltered.isEmpty) {
//   //     debugPrint('QListGlobalFiltered IS EMPTY');
//   //     navigate(MyScreen.listQuestion);
//   //   } else {
//   //     //refresh screen
//   //     navigate(MyScreen.listQuestionSingle);
//   //   }
//   // }
//
//   sendQuestionRemark() async {
//     // Object sendResult = await _questionService.sendQuestionRemark(remark.value!, appVersion);
//     // if (sendResult is Failure) {
//     //   setError(sendResult);
//     //   navigate(MyScreen.remark);
//     // } else {
//     //   setError(null);
//     //   setMessage(msgThanksForRemark);
//     //   navigate(MyScreen.quizQuestionSingle);
//     // }
//   }
//
//   ////////////////////////
//   //     VALIDATION     //
//   ////////////////////////
//
//   // void validateEmail(String val) {
//   //   _validationService.validateEmail(val);
//   //   notifyListeners();
//   // }
//   //
//   // void validatePassword(String val) {
//   //   _validationService.validatePassword(val);
//   //   notifyListeners();
//   // }
//
//   void validateEmailRemind(String val) {
//     // _validationService.validateEmailRemind(val);
//     // notifyListeners();
//   }
//
//   void validateRemark(String val) {
//     // _validationService.validateRemark(val);
//     // notifyListeners();
//   }
//
//
//
//
//   ////////////////////////
//   //      ROUTING       //
//   ////////////////////////
//
//   // GoRouter get router => _routeService.router;
//
//
//
//   // navigateNew(MyScreen screen) {
//   //   debugPrint('NAVIGATING to: $screen');
//   //
//   // }
//   // navigate(MyScreen screen) {
//   //   debugPrint('NAVIGATING to: $screen');
//   //   _ref.read(routeController).navigate(screen);
//   //   _currentScreen = screen;
//   //   // if (errorMsg.isNotEmpty) setError(null);
//   //   // notifyListeners();
//   // }
//
//
//
//   // Widget getQuestionIcon(String qId) {
//   //   return const Icon(Icons.check);
//   // }
//
// // String getBadgePath({int? rankLevel}) {
// //   String badge = '0';
// //   //if rank level is not given, return loggedUser badge
// //   if (rankLevel == null) badge = loggedUser!.rankLevel.toString();
// //   //if rankLevel is given, return corresponding badge
// //   if (rankLevel != null) badge = rankLevel.toString();
// //   return 'assets/images/badges/$badge.png';
// // }
// }
