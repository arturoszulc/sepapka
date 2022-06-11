import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/model_layer/calcs/heating_power_three_phase_calc_model.dart';
import '../../utils/consts/my_screens.dart';
import '../../utils/consts/all_screens_import.dart';
import '';
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
       debugLogDiagnostics: true,
     refreshListenable: GoRouterRefreshStream(streamScreenController.stream),
     initialLocation: MyScreen.signIn.path,
     routes: <GoRoute>[
   GoRoute(
   name: MyScreen.menu.name,
       path: MyScreen.menu.path, pageBuilder: (context, state) => MaterialPage(
       key: state.pageKey,
       child: const MenuScreen()),
     routes: [
       GoRoute(
           name: MyScreen.knowledgeBase.name,
           path: MyScreen.knowledgeBase.path, pageBuilder: (context, state) => MaterialPage(
           key: state.pageKey,
           child: const KnowledgeBaseMenu()),
       ),
       GoRoute(
         name: MyScreen.calcMenu.name,
         path: MyScreen.calcMenu.path, pageBuilder: (context, state) => MaterialPage(
           key: state.pageKey,
           child: ChangeNotifierProvider<CalcManager>(
               create: (context) => CalcManager(),
               builder: (context, _) => const CalculatorsMenuScreen())),
         routes: [
           GoRoute(
             name: MyScreen.calcHeatingPowerThreePhase.name,
             path: MyScreen.calcHeatingPowerThreePhase.path, pageBuilder: (context, state) => MaterialPage(
               key: state.pageKey,
               child: const CalcHeatingPowerThreePhase()),
           ),
         ]
       ),
     ]
   ),
       GoRoute(
         name: MyScreen.signIn.name,
         path: MyScreen.signIn.path, pageBuilder: (context, state) => MaterialPage(
           key: state.pageKey,
           child: SignInScreen()),
         routes: [
           GoRoute(
             name: MyScreen.resetPassword.name,
             path: MyScreen.resetPassword.path, pageBuilder: (context, state) => MaterialPage(
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
       // debugPrint('@@@ GoRouter redirect function deployed @@@');
       // debugPrint('@@@ stateLocation: ${state.location} @@@');
       // debugPrint('@@@ stateSubloc: ${state.subloc} @@@');
       // debugPrint('@@@ stateName: ${state.name} @@@');
       // debugPrint('@@@ state.Path: ${state.path} @@@');
       // debugPrint('@@@ state.namedLocation: ${state.namedLocation(currentScreen.name)} @@@');

       final bool goingToSignIn = state.location.endsWith(currentScreen.path);
       if (goingToSignIn) {
         debugPrint('### TEN SAM EKRAN! Nie robię nic...');
         return null;
       } else {
         debugPrint('### IDĘ ${currentScreen.name}');
         return state.namedLocation(currentScreen.name);
         // return MyScreen.signIn.name;
       // switch (currentScreen) {
       //   // case MyScreen.loading:
       //     // return MyScreen.loading.name;
       //   case MyScreen.signIn:
       //     debugPrint('Case: MyScreen.SignIn');
       //     return MyScreen.signIn.name;
       //   // case MyScreen.menu:
       //     // return const MenuScreen();
       //   case MyScreen.resetPassword:
       //     debugPrint('Case: MyScreen.resetPassword');
       //     return state.namedLocation(currentScreen.path);
       //   // // case MyScreen.settings:
       //   //   // return const SettingsScreen();
       //   // case MyScreen.chooseLevel:
       //   //   // return const MenuChooseLevel();
       //   // case MyScreen.quizQuestionSingle:
       //   //   // return QuestionQuizSingle();
       //   // case MyScreen.sessionFinished:
       //   //   // return SessionFinished();
       //   // case MyScreen.listQuestion:
       //   //   // return QuestionListScreen();
       //   // case MyScreen.remark:
       //   //   // return RemarkScreen();
       //   // case MyScreen.debug:
       //   //   // return DebugScreen();
       //   // case MyScreen.chooseCategory:
       //   //   // return ChooseCategory();
       //   // case MyScreen.listQuestionSingle:
       //   //   // return QuestionListSingle();
       //   // case MyScreen.listQuestionFilter:
       //   //   // return QuestionListFilter();
       //   // case MyScreen.purchase:
       //   //   // return PurchaseScreen();
       //   // case MyScreen.purchaseError:
       //   //   // return PurchaseError();
       //   // case MyScreen.purchaseSuccess:
       //   //   // return PurchaseSuccess();
       //   // case MyScreen.purchasePending:
       //   //   // return PurchasePending();
       //   // case MyScreen.knowledgeBase:
       //   //   // return const KnowledgeBaseMenu();
       //   // case MyScreen.tableWireColors:
       //   //   // return const WireColors();
       //   // case MyScreen.tableWireAmpacity:
       //   //   // return WireAmpacity();
       //   // case MyScreen.tableWireSymbols:
       //   //   // return WireSymbols();
       //   // case MyScreen.calcMenu:
       //   //   // return const CalculatorsMenuScreen();
       //   //   break;
       //   // case MyScreen.calcHeatingPowerThreePhase:
       //   //   // return CalcHeatingPowerThreePhase();
       //   //
       //   // case MyScreen.units:
       //   //   // return UnitsScreen();
       //   default: return null;
       // }
       }
     }

   );

 }






}