
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/ui/calculators/calc_voltage_divider.dart';
import 'package:sepapka/ui/tables/table_units.dart';
import 'package:sepapka/ui/purchase/purchase_wrapper.dart';

import 'package:sepapka/controllers/app_state_controller.dart';
import '../../utils/consts/my_screens.dart';
import '../../utils/consts/all_screens_import.dart';
import '../models/app_state.dart';
import '../ui/academy/academy_index.dart';
import '../ui/academy/academy_lesson.dart';
import '../ui/academy/academy_unit.dart';
import '../ui/calculators/calc_ohms_law.dart';
import '../ui/tables/table_wire_diameter.dart';

/// Caches and Exposes a [GoRouter]
final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    initialLocation: MyScreen.loading.path,
    // debugLogDiagnostics: true,
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
    final bool isLoading = _ref.read(appStateNotifierProvider).isLoading;
    final bool isUserSignedIn = _ref.read(appStateNotifierProvider).isSignedIn;
    final bool isUserSignedOut = _ref.read(appStateNotifierProvider).isSignedOut;
    // final bool isSignInError = _ref.read(appStateNotifierProvider).signInError;
    final bool isQuizFinished = _ref.read(appStateNotifierProvider).isQuizFinished;

    final bool isAppLoading = state.subloc.contains(MyScreen.loading.path);
    final bool isInApp = state.subloc.contains(MyScreen.menu.path);
    final isInSignIn = state.subloc.contains(MyScreen.sing_in.path);
    final isInQuiz = state.subloc.contains(MyScreen.quiz_menu.path);
    final isInQuizFinished = state.subloc.contains(MyScreen.quiz_finished.path);

    if (isLoading && !isAppLoading) return state.namedLocation(MyScreen.loading.name);
    // if (!isUserSignedIn && !isUserSignedOut && !isAppLoading) return state.namedLocation(MyScreen.loading.name);
    if (isUserSignedOut && !isInSignIn && !isLoading) return state.namedLocation(MyScreen.sing_in.name);
    if (isUserSignedIn && !isInApp && !isLoading) return state.namedLocation(MyScreen.menu.name);

    //Quiz
    if (isInQuiz && isQuizFinished && !isInQuizFinished) return state.namedLocation(MyScreen.quiz_finished.name);
    if (isInQuizFinished && !isQuizFinished) return state.namedLocation(MyScreen.menu.name);


    return null;
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
  name: MyScreen.sing_in.name,
  path: MyScreen.sing_in.path,
  pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: SignInScreen()),
  routes: _authSubRoutes,
  ),
  ];
}

  List<GoRoute> get _menuSubRoutes {
    return <GoRoute>[
      GoRoute(
        name: MyScreen.quiz_menu.name,
        path: MyScreen.quiz_menu.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QuizMenu()),
        routes: _quizSubRoutes,
      ),
      GoRoute(
        name: MyScreen.academy_menu.name,
        path: MyScreen.academy_menu.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const AcademyMenu()),
        routes: _academySubRoutes,
      ),
      GoRoute(
        name: MyScreen.tables_menu.name,
        path: MyScreen.tables_menu.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const TablesMenu()),
        routes: _tablesSubRoutes,
      ),
      GoRoute(
        name: MyScreen.calc_menu.name,
        path: MyScreen.calc_menu.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const CalculatorsMenuScreen()),
        routes: _calcSubRoutes,
      ),
      GoRoute(
        name: MyScreen.purchase_wrapper.name,
        path: MyScreen.purchase_wrapper.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const PurchaseWrapper()),
      ),
    ];
  }

  List<GoRoute> get _quizSubRoutes {
    return <GoRoute> [
      GoRoute(
        name: MyScreen.quiz_choose_level.name,
        path: MyScreen.quiz_choose_level.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const MenuChooseLevel()),
        routes: [
          GoRoute(
            name: MyScreen.quiz_choose_category.name,
            path: MyScreen.quiz_choose_category.path,
            pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const ChooseCategory()),
          ),
        ]
      ),
      GoRoute(
        name: MyScreen.list_question.name,
        path: MyScreen.list_question.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QuestionListScreen()),
        routes: _listQuestionSubRoutes,
      ),
      GoRoute(
        name: MyScreen.quiz_question_single.name,
        path: MyScreen.quiz_question_single.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QuizSingleQuestion()),
      ),
      GoRoute(
        name: MyScreen.quiz_finished.name,
        path: MyScreen.quiz_finished.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QuizFinished()),
      ),
      GoRoute(
        name: MyScreen.remark.name,
        path: MyScreen.remark.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const RemarkScreen()),
      ),
    ];
  }

  List<GoRoute> get _listQuestionSubRoutes {
    return <GoRoute>[
      GoRoute(
        name: MyScreen.list_question_filter.name,
        path: MyScreen.list_question_filter.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QuestionListFilter()),
      ),
      GoRoute(
        name: MyScreen.list_question_single.name,
        path: MyScreen.list_question_single.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QuestionListSingle()),
      ),
    ];
  }

  List<GoRoute> get _academySubRoutes {
    return <GoRoute>[
      GoRoute(
        name: MyScreen.academy_unit.name,
        path: MyScreen.academy_unit.path,// + '/:uid',
        pageBuilder: (context, state) {
          // final Unit unit = academyUnits.firstWhere((unit) => unit.id == state.params['uid']!,
          //     orElse: () => Unit.empty());
          return MaterialPage(key: state.pageKey, child: const AcademyUnit());},
      routes: [
        GoRoute(
          name: MyScreen.academy_lesson.name,
          path: MyScreen.academy_lesson.path,// + '/:id',
          pageBuilder: (context, state) {
            // final Lesson lesson = cableLessons.firstWhere((lesson) => lesson.id == state.params['id']!,
            //     orElse: () => Lesson.empty());
            return MaterialPage(key: state.pageKey, child: AcademyLesson());},
        ),
      ]
      ),

      GoRoute(
        name: MyScreen.academy_index.name,
        path: MyScreen.academy_index.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: AcademyIndex()),
      ),
    ];
  }

  List<GoRoute> get _tablesSubRoutes {
    return <GoRoute>[
      GoRoute(
        name: MyScreen.table_wire_ampacity.name,
        path: MyScreen.table_wire_ampacity.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const TableWireAmpacity()),
      ),
      GoRoute(
        name: MyScreen.table_wire_colors.name,
        path: MyScreen.table_wire_colors.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const TableWireColors()),
      ),
      GoRoute(
        name: MyScreen.table_wire_symbols.name,
        path: MyScreen.table_wire_symbols.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const TableWireSymbols()),
      ),
      GoRoute(
        name: MyScreen.table_wire_diameter.name,
        path: MyScreen.table_wire_diameter.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const TableWireDiameter()),
      ),
      GoRoute(
        name: MyScreen.table_units.name,
        path: MyScreen.table_units.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: TableUnits()),
      ),
    ];
  }


  List<GoRoute> get _calcSubRoutes {
    return <GoRoute>[
      GoRoute(
        name: MyScreen.calc_ohms_law.name,
        path: MyScreen.calc_ohms_law.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const CalcOhmsLaw()),
      ),
      GoRoute(
        name: MyScreen.calc_voltage_divider.name,
        path: MyScreen.calc_voltage_divider.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const CalcVoltageDivider()),
      ),
      GoRoute(
        name: MyScreen.calc_heating_power_three_phase.name,
        path: MyScreen.calc_heating_power_three_phase.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const CalcHeatingPowerThreePhase()),
      ),



    ];
  }

  List<GoRoute> get _authSubRoutes {
    return <GoRoute>[
      GoRoute(
        name: MyScreen.reset_password.name,
        path: MyScreen.reset_password.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: ResetPasswordScreen()),
      ),
    ];
  }

}
