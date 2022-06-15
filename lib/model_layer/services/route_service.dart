import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/viewmodel_layer/route_controller.dart';
import '../../utils/consts/my_screens.dart';
import '../../utils/consts/all_screens_import.dart';



/// Caches and Exposes a [GoRouter]
final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    debugLogDiagnostics: true, // For demo purposes
    refreshListenable: router, // This notifiies `GoRouter` for refresh events
    redirect: router._redirectLogic, // All the logic is centralized here
    routes: router._routes, // All the routes can be found there
      errorBuilder: (context, state) => Scaffold(body: Center(child: Text(state.error.toString()))),
  );
});

/// This notifier exists only for notifying GoRouter refreshListenable
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  /// This implementation exploits `ref.listen()` to add a simple callback that
  /// calls `notifyListeners()` whenever there's change onto a desider provider.
  RouterNotifier(this._ref) {
    _ref.listen<MyScreen>(
      routerStateProvider, // In our case, we're interested in the log in / log out events.
          (_, __) => notifyListeners(), // Obviously more logic can be added here
    );
  }


  /// IMPORTANT: conceptually, we want to use `ref.read` to read providers, here.
  /// GoRouter is already aware of state changes through `refreshListenable`
  /// We don't want to trigger a rebuild of the surrounding provider.
  String? _redirectLogic(GoRouterState state) {
           debugPrint('@@@ GoRouter redirect function deployed @@@');
           debugPrint('@@@ GoRouter current location: ${state.location} @@@');
           debugPrint('@@@ GoRouter current path: ${state.path} @@@');
    //get path of current screen
    MyScreen nextScreen = _ref
        .read(routerStateProvider);
           debugPrint('@@@ NextPath: ${nextScreen.toString()} @@@');
final isRedirectManual =
           final bool isSameScreen = state.location.endsWith(nextScreen.path);
    if (isSameScreen) return null;
       return state.namedLocation(nextScreen.name);
  }


  List<GoRoute> get _routes =>
      <GoRoute>[
        GoRoute(
            name: MyScreen.menu.name,
            path: MyScreen.menu.path, pageBuilder: (context, state) =>
            MaterialPage(
                key: state.pageKey,
                child: const MenuScreen()),
            routes: <GoRoute>[
              GoRoute(
                name: MyScreen.knowledgeBase.name,
                path: MyScreen.knowledgeBase.path, pageBuilder: (context, state) =>
                  MaterialPage(
                      key: state.pageKey,
                      child: const KnowledgeBaseMenu()),
              ),
              GoRoute(
                  name: MyScreen.calcMenu.name,
                  path: MyScreen.calcMenu.path, pageBuilder: (context, state) =>
                  MaterialPage(
                      key: state.pageKey,
                      child: const CalculatorsMenuScreen()),
                  routes: [
                    GoRoute(
                      name: MyScreen.calcHeatingPowerThreePhase.name,
                      path: MyScreen.calcHeatingPowerThreePhase.path,
                      pageBuilder: (context, state) =>
                          MaterialPage(
                              key: state.pageKey,
                              child: const CalcHeatingPowerThreePhase()),
                    ),
                  ]
              ),
            ]
        ),
        GoRoute(
          name: MyScreen.signIn.name,
          path: MyScreen.signIn.path, pageBuilder: (context, state) =>
            MaterialPage(
                key: state.pageKey,
                child: SignInScreen()),
          routes: [
            GoRoute(
              name: MyScreen.resetPassword.name,
              path: MyScreen.resetPassword.path, pageBuilder: (context, state) =>
                MaterialPage(
                  key: state.pageKey,
                  child: ResetPasswordScreen(),
                ),
            ),
          ],
        ),


      ];

}

// @immutable
// class RouteService {
//   late final GoRouter router;
//   // MyScreen currentScreen = MyScreen.signIn;
//   // ValueNotifier<MyScreen> _myString = ValueNotifier<MyScreen>(MyScreen.loading);
//   final StreamController<MyScreen> streamScreenController = StreamController<MyScreen>();
//
//  RouteService() {
//    debugPrint('@@@ RouteService Initialized @@@');
//    initRouter();
//
//  }
//
//  navigate(MyScreen screen) {
//    debugPrint('@@@ Called NAVIGATE method in routeService');
//    // currentScreen = screen;
//    streamScreenController.add(screen);
//  }
//
//
//  initRouter() {
//    router = GoRouter(
//        debugLogDiagnostics: true,
//      refreshListenable: GoRouterRefreshStream(streamScreenController.stream),
//      initialLocation: MyScreen.signIn.path,
//      routes: <GoRoute>[
//    GoRoute(
//    name: MyScreen.menu.name,
//        path: MyScreen.menu.path, pageBuilder: (context, state) => MaterialPage(
//        key: state.pageKey,
//        child: const MenuScreen()),
//      routes: [
//        GoRoute(
//            name: MyScreen.knowledgeBase.name,
//            path: MyScreen.knowledgeBase.path, pageBuilder: (context, state) => MaterialPage(
//            key: state.pageKey,
//            child: const KnowledgeBaseMenu()),
//        ),
//        GoRoute(
//          name: MyScreen.calcMenu.name,
//          path: MyScreen.calcMenu.path, pageBuilder: (context, state) => MaterialPage(
//            key: state.pageKey,
//            child: const CalculatorsMenuScreen()),
//          routes: [
//            GoRoute(
//              name: MyScreen.calcHeatingPowerThreePhase.name,
//              path: MyScreen.calcHeatingPowerThreePhase.path, pageBuilder: (context, state) => MaterialPage(
//                key: state.pageKey,
//                child: const CalcHeatingPowerThreePhase()),
//            ),
//          ]
//        ),
//      ]
//    ),
//        GoRoute(
//          name: MyScreen.signIn.name,
//          path: MyScreen.signIn.path, pageBuilder: (context, state) => MaterialPage(
//            key: state.pageKey,
//            child: SignInScreen()),
//          routes: [
//            GoRoute(
//              name: MyScreen.resetPassword.name,
//              path: MyScreen.resetPassword.path, pageBuilder: (context, state) => MaterialPage(
//              key: state.pageKey,
//              child: ResetPasswordScreen(),
//            ),
//            ),
//          ],
//        ),
//
//      ],
//      errorBuilder: (context, state) => Scaffold(body: Center(child: Text(state.error.toString())
//      ),
//      ),
//
//      redirect: (state) {
//        // debugPrint('@@@ GoRouter redirect function deployed @@@');
//        // debugPrint('@@@ stateLocation: ${state.location} @@@');
//        // debugPrint('@@@ stateSubloc: ${state.subloc} @@@');
//        // debugPrint('@@@ stateName: ${state.name} @@@');
//        // debugPrint('@@@ state.Path: ${state.path} @@@');
//        // debugPrint('@@@ state.namedLocation: ${state.namedLocation(currentScreen.name)} @@@');
//         final currentScreen = streamScreenController.stream.listen((event) => event.path);
//        final bool goingToSignIn = state.location.endsWith(currentScreen);
//        if (goingToSignIn) {
//          debugPrint('### TEN SAM EKRAN! Nie robię nic...');
//          return null;
//        } else {
//          debugPrint('### IDĘ ${currentScreen.name}');
//          return state.namedLocation(currentScreen.name);
//          // return MyScreen.signIn.name;
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