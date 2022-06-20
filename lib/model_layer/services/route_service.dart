import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/model_layer/services/auth_service.dart';
import '';
import '';
import 'package:sepapka/viewmodel_layer/route_controller.dart';
import '../../utils/consts/my_screens.dart';
import '../../utils/consts/all_screens_import.dart';

/// Caches and Exposes a [GoRouter]
final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    initialLocation: MyScreen.signIn.path,
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
  MyScreen lastScreenAuto = MyScreen.signIn;

  /// This implementation exploits `ref.listen()` to add a simple callback that
  /// calls `notifyListeners()` whenever there's change onto a desider provider.
  RouterNotifier(this._ref) {
    _ref.listen<bool>(
      routeController, // In our case, we're interested in the log in / log out events.
      (_, __) => notifyListeners(), // Obviously more logic can be added here
    );
  }

  /// IMPORTANT: conceptually, we want to use `ref.read` to read providers, here.
  /// GoRouter is already aware of state changes through `refreshListenable`
  /// We don't want to trigger a rebuild of the surrounding provider.
  String? _redirectLogic(GoRouterState state) {
    final lastScreen = _ref.read(screenState);
    final isAuthenticated = _ref.read(authStateProvider);
    // debugPrint('@@@ GoRouter redirect function deployed @@@');
    // debugPrint('@@@ GoRouter state.location: ${state.location} @@@');
    // debugPrint('@@@ GoRouter LastScreenManual: $lastScreenManual @@@');
    // debugPrint('@@@ GoRouter state.name: ${state.name} @@@');
    //get path of current screen
    final bool isSameScreen = state.location.endsWith(lastScreen.path);
    if (isSameScreen) {
      // debugPrint('The Screen is the same');
      return null;
    }
    final location = state.namedLocation(lastScreen.name);
    // debugPrint('@@@ Resolved new location name');
    return location;
  }

  //po wywołaniu navigate(menu) jest:
// Gorouter location: /menu
  //Gorouter name: null
  //NextScreeN: menu

  List<GoRoute> get _topLevelRoutes => <GoRoute>[
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
        GoRoute(
          name: MyScreen.quizQuestionSingle.name,
          path: MyScreen.quizQuestionSingle.path,
          pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const QuizSingleQuestion()),
        ),
      ];

  List<GoRoute> get _menuSubRoutes {
    return <GoRoute>[
      GoRoute(
        name: MyScreen.quizChooseLevel.name,
        path: MyScreen.quizChooseLevel.path,
        pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const MenuChooseLevel()),
        routes: <GoRoute>[
          GoRoute(
            name: MyScreen.quizChooseCategory.name,
            path: MyScreen.quizChooseCategory.path,
            pageBuilder: (context, state) => MaterialPage(key: state.pageKey, child: const ChooseCategory()),
          ),
        ],
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


//        // switch (currentScreen) {
//        //   // case MyScreen.loading:
//        //     // return MyScreen.loading.name;
//        //   case MyScreen.signIn:
//        //     debugPrint('Case: MyScreen.SignIn');
//        //     return MyScreen.signIn.name;
//        //   // case MyScreen.menu:
//        //     // return const MenuScreen();
//        //   case MyScreen.resetPassword:
//        //     debugPrint('Case: MyScreen.resetPassword');
//        //     return state.namedLocation(currentScreen.path);
//        //   // // case MyScreen.settings:
//        //   //   // return const SettingsScreen();
//        //   // case MyScreen.chooseLevel:
//        //   //   // return const MenuChooseLevel();
//        //   // case MyScreen.quizQuestionSingle:
//        //   //   // return QuestionQuizSingle();
//        //   // case MyScreen.sessionFinished:
//        //   //   // return SessionFinished();
//        //   // case MyScreen.listQuestion:
//        //   //   // return QuestionListScreen();
//        //   // case MyScreen.remark:
//        //   //   // return RemarkScreen();
//        //   // case MyScreen.debug:
//        //   //   // return DebugScreen();
//        //   // case MyScreen.chooseCategory:
//        //   //   // return ChooseCategory();
//        //   // case MyScreen.listQuestionSingle:
//        //   //   // return QuestionListSingle();
//        //   // case MyScreen.listQuestionFilter:
//        //   //   // return QuestionListFilter();
//        //   // case MyScreen.purchase:
//        //   //   // return PurchaseScreen();
//        //   // case MyScreen.purchaseError:
//        //   //   // return PurchaseError();
//        //   // case MyScreen.purchaseSuccess:
//        //   //   // return PurchaseSuccess();
//        //   // case MyScreen.purchasePending:
//        //   //   // return PurchasePending();
//        //   // case MyScreen.knowledgeBase:
//        //   //   // return const KnowledgeBaseMenu();
//        //   // case MyScreen.tableWireColors:
//        //   //   // return const WireColors();
//        //   // case MyScreen.tableWireAmpacity:
//        //   //   // return WireAmpacity();
//        //   // case MyScreen.tableWireSymbols:
//        //   //   // return WireSymbols();
//        //   // case MyScreen.calcMenu:
//        //   //   // return const CalculatorsMenuScreen();
//        //   //   break;
//        //   // case MyScreen.calcHeatingPowerThreePhase:
//        //   //   // return CalcHeatingPowerThreePhase();
//        //   //
//        //   // case MyScreen.units:
//        //   //   // return UnitsScreen();
//        //   default: return null;
//        // }
//        }
//      }
//
//    );
//
//  }
//
//
//
//
//
//
// }
