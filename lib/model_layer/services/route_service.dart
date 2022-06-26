
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sepapka/viewmodel_layer/app_state_controller.dart';
import '../../utils/consts/my_screens.dart';
import '../../utils/consts/all_screens_import.dart';
import '../models/appState.dart';

/// Caches and Exposes a [GoRouter]
final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    initialLocation: MyScreen.loading.path,
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
  // String lastRoute = MyScreen.loading.path;

  /// This implementation exploits `ref.listen()` to add a simple callback that
  /// calls `notifyListeners()` whenever there's change onto a desider provider.
  RouterNotifier(this._ref) {
    _ref.listen<AppState>(
      appStateNotifierProvider,
      (_, __) {
        log('/// appStateNotifierProvider CHANGED ///');
        notifyListeners();}, // notify only if true
    );
  }

  /// IMPORTANT: conceptually, we want to use `ref.read` to read providers, here.
  /// GoRouter is already aware of state changes through `refreshListenable`
  /// We don't want to trigger a rebuild of the surrounding provider.
  String? _redirectLogic(GoRouterState state) {
    log('&&& GoRouter redirect method deployed &&&');
    // log('@@@ GoRouter state.location: ${state.location} @@@');
    // log('@@@ GoRouter state.subLoc: ${state.subloc} @@@');
    // log('@@@ GoRouter state.name: ${state.name} @@@');

    //App statuses
    final bool isUserSignedIn = _ref.read(appStateNotifierProvider).isSignedIn;
    final bool isUserSignedOut = _ref.read(appStateNotifierProvider).isSignedOut;
    final bool appInitError = _ref.read(appStateNotifierProvider).fetchDataError;

    final bool isAppLoading = state.subloc.contains(MyScreen.loading.path);
    final bool isInApp = state.subloc.contains(MyScreen.menu.path);
    final isInSignIn = state.subloc.contains(MyScreen.signIn.path);

    if (!isUserSignedIn && !isUserSignedOut && !isAppLoading) return state.namedLocation(MyScreen.loading.name);
    if ((isUserSignedOut || appInitError) && !isInSignIn) return state.namedLocation(MyScreen.signIn.name);
    if (isUserSignedIn && !isInApp) return state.namedLocation(MyScreen.menu.name);
    return null;

    // // final isAuthenticated = _ref.read(authStateProvider).value != null;
    // debugPrint('@@@ GoRouter redirect function deployed @@@');
    // // debugPrint('@@@ GoRouter LastScreenManual: $lastScreenManual @@@');
    // debugPrint('@@@ GoRouter state.name: ${state.name} @@@');
    // //get path of current screen
    // final routingTo = state.location;
    // final bool isSameScreen = goingTo.endsWith(autoScreen.path);
    //
    // //first check if screen is the same
    // if (isSameScreen) {
    //   // debugPrint('The Screen is the same');
    //   return null;
    // }
    //
    // //if not, check wether destination is different than current screen
    // // final bool isDestinationDifferent =
    //
    //
    // // //auth permission
    // //
    // // if (!isAuthenticated && !isSameScreen) {
    // //   log('%^&*(%^ USER NOT AUTHENTICATED');
    // //   return state.namedLocation(MyScreen.signIn.name);
    // // }
    // //TODO: Refactor: manual vs. auto routing must be recognized
    // final location = state.namedLocation(autoScreen.name);
    // // debugPrint('@@@ Resolved new location name');
    // return location;
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
