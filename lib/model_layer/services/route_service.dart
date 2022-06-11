import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/consts/nav.dart';
import '../../utils/consts/all_screens.dart';
class RouteService {

  late GoRouter router;
  MyScreen currentScreen = MyScreen.signIn;
  // ValueNotifier<MyScreen> _myString = ValueNotifier<MyScreen>(MyScreen.loading);
  StreamController<MyScreen> streamScreenController = StreamController<MyScreen>();

 RouteService() {
   debugPrint('@@@ RouteService Initialized @@@');
   initRouter();

 }

 navigate(MyScreen screen) {
   debugPrint('@@@ Called NAVIGATE method in routeService');
   currentScreen = screen;
   streamScreenController.add(screen);
 }


 initRouter() {
   router = GoRouter(
     refreshListenable: GoRouterRefreshStream(streamScreenController.stream),
     initialLocation: '/signIn',
     routes: <GoRoute>[
       GoRoute(
         name: MyScreen.signIn.name,
         path: '/signIn', pageBuilder: (context, state) => MaterialPage(
           key: state.pageKey,
           child: SignInScreen()),
         routes: [
           GoRoute(
             name: MyScreen.resetPassword.name,
             path: 'reset-password', pageBuilder: (context, state) => MaterialPage(
             key: state.pageKey,
             child: ResetPasswordScreen(),
           ),
           ),
         ],
       ),

     ],
     errorBuilder: (context, state) => Scaffold(body: Center(child: Text(state.error.toString())
     ),
     ),

     redirect: (state) {
       debugPrint('@@@ GoRouter redirect function deployed @@@');

       final bool goingToSignIn = state.subloc == MyScreen.signIn.name;
       final bool toSignIn = prefs.containsKey
       if (goingToSignIn) {
         debugPrint('### TEN SAM EKRAN! Nie robię nic...');
         return null;
       } else {
       switch (currentScreen) {
         // case MyScreen.loading:
           // return MyScreen.loading.name;
         case MyScreen.signIn:
           debugPrint('Case: MyScreen.SignIn');
           return MyScreen.signIn.name;
         // case MyScreen.menu:
           // return const MenuScreen();
         case MyScreen.resetPassword:
           debugPrint('Case: MyScreen.resetPassword');
           return MyScreen.resetPassword.name;
         // // case MyScreen.settings:
         //   // return const SettingsScreen();
         // case MyScreen.chooseLevel:
         //   // return const MenuChooseLevel();
         // case MyScreen.quizQuestionSingle:
         //   // return QuestionQuizSingle();
         // case MyScreen.sessionFinished:
         //   // return SessionFinished();
         // case MyScreen.listQuestion:
         //   // return QuestionListScreen();
         // case MyScreen.remark:
         //   // return RemarkScreen();
         // case MyScreen.debug:
         //   // return DebugScreen();
         // case MyScreen.chooseCategory:
         //   // return ChooseCategory();
         // case MyScreen.listQuestionSingle:
         //   // return QuestionListSingle();
         // case MyScreen.listQuestionFilter:
         //   // return QuestionListFilter();
         // case MyScreen.purchase:
         //   // return PurchaseScreen();
         // case MyScreen.purchaseError:
         //   // return PurchaseError();
         // case MyScreen.purchaseSuccess:
         //   // return PurchaseSuccess();
         // case MyScreen.purchasePending:
         //   // return PurchasePending();
         // case MyScreen.knowledgeBase:
         //   // return const KnowledgeBaseMenu();
         // case MyScreen.tableWireColors:
         //   // return const WireColors();
         // case MyScreen.tableWireAmpacity:
         //   // return WireAmpacity();
         // case MyScreen.tableWireSymbols:
         //   // return WireSymbols();
         // case MyScreen.calcMenu:
         //   // return const CalculatorsMenuScreen();
         //   break;
         // case MyScreen.calcHeatingPowerThreePhase:
         //   // return CalcHeatingPowerThreePhase();
         //
         // case MyScreen.units:
         //   // return UnitsScreen();
         default: return null;
       }}
     }

   );

 }






}