import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/consts/my_screens.dart';
// import 'package:flutter/material.dart';


final screenState = StateProvider<MyScreen>((ref) => MyScreen.signIn);


//the routerState only purpose is to notify GoRouter that screen was switched
final routeController = Provider<RouteController>((ref) {
  return RouteController(ref);
});

class RouteController {
  RouteController(this._ref) {
    // log('^^^ RouterController initialized ^^^');
  }

  final Ref _ref;

  void navigate(MyScreen screen) {
    _ref.read(screenState.notifier).state = screen;
    // log('@@@### RouterState.navigate deployed ###@@@');
    // if (state == screen) state = MyScreen.loading;
    // state = screen;
  }
}
