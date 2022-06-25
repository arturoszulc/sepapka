
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/model_layer/services/auth_service.dart';
import 'package:sepapka/view_layer/question_list/question_list_filter.dart';
import 'package:sepapka/view_layer/question_list/question_list_screen.dart';
import 'package:sepapka/view_layer/question_list/question_list_single.dart';
import 'package:sepapka/view_layer/question_quiz/quiz_menu.dart';
import 'package:sepapka/view_layer/question_quiz/remark_screen.dart';
import 'package:sepapka/view_layer/question_quiz/session_finished_screen.dart';
import 'package:sepapka/viewmodel_layer/route_controller.dart';
import '../../utils/consts/my_screens.dart';
import '../../utils/consts/all_screens_import.dart';

/// Caches and Exposes a [GoRouter]
final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    // initialLocation: MyScreen.signIn.path,
    debugLogDiagnostics: true,
    // For demo purposes
    refreshListenable: router,
    // This notifiies `GoRouter` for refresh events
    redirect: router._redirectLogic,
    // All the logic is centralized here
    routes: router._topLevelRoutes,
    // All the routes can be found there
    errorBuilder: (context, state) => Scaffold(body: Center(child: Text(state.error.toString()))),
  );
});

/// This notifier exists only for notifying GoRouter refreshListenable
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  // MyScreen lastScreenAuto = MyScreen.loading;

  /// This implementation exploits `ref.listen()` to add a simple callback that
  /// calls `notifyListeners()` whenever there's change onto a desider provider.
  RouterNotifier(this._ref) {
    _ref.listen<bool>(
      screenSwitched,
      (autoSwitched, __) => autoSwitched! ? notifyListeners() : null, // notify only if true
    );
  }

  /// IMPORTANT: conceptually, we want to use `ref.read` to read providers, here.
  /// GoRouter is already aware of state changes through `refreshListenable`
  /// We don't want to trigger a rebuild of the surrounding provider.
  String? _redirectLogic(GoRouterState state) {
    log('&&& GoRouter redirect method deployed &&&');

//     ////// NEW //////
//     final goingTo = state.location;
//     final lastScreenName = _ref.read(autoScreenName);
//
//     final bool isSameScreen = goingTo.endsWith(autoScreen.path);
//     if (isSameScreen) {
//       return null;
//     } else {
//
//      _ref.read(autoScreenName.notifier).state = state.name!;
//     }
//     ////// END NEW //////
//
//
//
//     final goingTo = state.location;
//     final autoScreen = _ref.read(autoScreenName);
//     final isAutoSwitched = _ref.read(screenSwitched);
//
//     if (isAutoSwitched) {
// //if screen was switched without user interaction,
//
// // check if the route is not in progress (to avoid loop)
//     final bool isSameScreen = goingTo.endsWith(autoScreen.path);
//       if (isSameScreen) return null;
//       _ref.read(screenSwitched.notifier).state = false; //reset auto-route flag
//       return state.namedLocation(autoScreen.name); //go to the screen
//     }
//
//     //if screen was not switched automatically (user called context.go / context.push
//     else {
//
//     }

    // final isAuthenticated = _ref.read(authStateProvider).value != null;
    debugPrint('@@@ GoRouter redirect function deployed @@@');
    debugPrint('@@@ GoRouter state.location: ${state.location} @@@');
    // debugPrint('@@@ GoRouter LastScreenManual: $lastScreenManual @@@');
    debugPrint('@@@ GoRouter state.name: ${state.name} @@@');
    //get path of current screen
    final routingTo = state.location;
    final bool isSameScreen = goingTo.endsWith(autoScreen.path);

    //first check if screen is the same
    if (isSameScreen) {
      // debugPrint('The Screen is the same');
      return null;
    }

    //if not, check wether destination is different than current screen
    // final bool isDestinationDifferent =


    // //auth permission
    //
    // if (!isAuthenticated && !isSameScreen) {
    //   log('%^&*(%^ USER NOT AUTHENTICATED');
    //   return state.namedLocation(MyScreen.signIn.name);
    // }
    //TODO: Refactor: manual vs. auto routing must be recognized
    final location = state.namedLocation(autoScreen.name);
    // debugPrint('@@@ Resolved new location name');
    return location;
  }
  List<GoRoute> get _topLevelRoutes {
    return <GoRoute>[
  GoRoute(
  name: MyScreen.loading.name,
  path: MyScreen.loading.path,
  pageBuilder: (context, state) => MaterialPage(
  key: state.pageKey,
  child: const LoadingScreen(),
  )),
  GoRoute(
  name: MyScreen.menu.name,
  path: MyScreen.menu.path,
  pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const MenuScreen()),
  routes: _menuSubRoutes,
  ),
  GoRoute(
  name: MyScreen.signIn.name,
  path: MyScreen.signIn.path,
  pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: SignInScreen()),
  routes: _authSubRoutes,
  ),
  ];
}

  List<GoRoute> get _menuSubRoutes {
    return <GoRoute>[
      GoRoute(
        name: MyScreen.quizMenu.name,
        path: MyScreen.quizMenu.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QuizMenu()),
        routes: _quizSubRoutes,
      ),
      GoRoute(
        name: MyScreen.listQuestion.name,
        path: MyScreen.listQuestion.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QuestionListScreen()),
        routes: _listQuestionSubRoutes,
      ),
      GoRoute(
        name: MyScreen.academyMenu.name,
        path: MyScreen.academyMenu.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const AcademyMenu()),
        routes: _academySubRoutes,
      ),
      GoRoute(
        name: MyScreen.calcMenu.name,
        path: MyScreen.calcMenu.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const CalculatorsMenuScreen()),
        routes: _calcSubRoutes,
      ),
    ];
  }

  List<GoRoute> get _quizSubRoutes {
    return <GoRoute> [
      GoRoute(
        name: MyScreen.quizChooseLevel.name,
        path: MyScreen.quizChooseLevel.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const MenuChooseLevel()),
        routes: [
          GoRoute(
            name: MyScreen.quizChooseCategory.name,
            path: MyScreen.quizChooseCategory.path,
            pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const ChooseCategory()),
          ),
        ]
      ),

      GoRoute(
        name: MyScreen.quizQuestionSingle.name,
        path: MyScreen.quizQuestionSingle.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QuizSingleQuestion()),
      ),
      GoRoute(
        name: MyScreen.quizFinished.name,
        path: MyScreen.quizFinished.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QuizFinished()),
      ),
      GoRoute(
        name: MyScreen.remark.name,
        path: MyScreen.remark.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: RemarkScreen()),
      ),
    ];
  }

  List<GoRoute> get _listQuestionSubRoutes {
    return <GoRoute>[
      GoRoute(
        name: MyScreen.listQuestionFilter.name,
        path: MyScreen.listQuestionFilter.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QuestionListFilter()),
      ),
      GoRoute(
        name: MyScreen.listQuestionSingle.name,
        path: MyScreen.listQuestionSingle.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QuestionListSingle()),
      ),
    ];
  }

  List<GoRoute> get _academySubRoutes {
    return <GoRoute>[
      GoRoute(
        name: MyScreen.tablesMenu.name,
        path: MyScreen.tablesMenu.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const TablesMenu()),
        routes: _tablesSubRoutes,
      ),
    ];
  }

  List<GoRoute> get _calcSubRoutes {
    return <GoRoute>[
      GoRoute(
        name: MyScreen.calcHeatingPowerThreePhase.name,
        path: MyScreen.calcHeatingPowerThreePhase.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const CalcHeatingPowerThreePhase()),
      ),
    ];
  }

  List<GoRoute> get _authSubRoutes {
    return <GoRoute>[
      GoRoute(
        name: MyScreen.resetPassword.name,
        path: MyScreen.resetPassword.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: ResetPasswordScreen()),
      ),
    ];
  }

  List<GoRoute> get _tablesSubRoutes {
    return <GoRoute>[
      GoRoute(
        name: MyScreen.tableWireAmpacity.name,
        path: MyScreen.tableWireAmpacity.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const TableWireAmpacity()),
      ),
      GoRoute(
        name: MyScreen.tableWireColors.name,
        path: MyScreen.tableWireColors.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const TableWireColors()),
      ),
      GoRoute(
        name: MyScreen.tableWireSymbols.name,
        path: MyScreen.tableWireSymbols.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const TableWireSymbols()),
      ),
    ];
  }
}
