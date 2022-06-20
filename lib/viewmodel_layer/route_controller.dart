import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/consts/my_screens.dart';
import 'package:flutter/material.dart';


final screenState = StateProvider<MyScreen>((ref) => MyScreen.signIn);


//the routerState only purpose is to notify GoRouter that screen was switched
final routeController = StateNotifierProvider<RouteController, bool>((ref) {
  return RouteController(ref);
});

class RouteController extends StateNotifier<bool> {
  RouteController(this._ref) : super(false); // : super(MyScreen.loading);

  final Ref _ref;

  void navigate(MyScreen screen) {
    _ref.read(screenState.notifier).state = screen;
    debugPrint('@@@### RouterState.navigate deployed ###@@@');
    // if (state == screen) state = MyScreen.loading;
    // state = screen;
    state = !state;
  }
}
