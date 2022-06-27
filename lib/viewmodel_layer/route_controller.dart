import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/consts/my_screens.dart';
// import 'package:flutter/material.dart';


final autoScreenName = StateProvider<String>((ref) => MyScreen.loading.name);
final screenSwitched = StateProvider<bool>((ref) => false);


//the routerState only purpose is to notify GoRouter that screen was switched
// final routeController = Provider<RouteController>((ref) {
//   return RouteController(ref);
// });

class RouteController {
  RouteController(this._ref) {
    log('^^^ RouterController initialized ^^^');
  }

  final Ref _ref;
  void navigate(MyScreen screen) {
    _ref.read(autoScreenName.notifier).state = screen.name;

    //let know that screen was switched manually
    _ref.read(screenSwitched.notifier).state = true;

    // final bool switchStatus = _ref.read(screenSwitched.notifier).state;
    // _ref.read(screenSwitched.notifier).state = !switchStatus; //just a simple flag to switch screen
    // log('@@@### RouterState.navigate deployed ###@@@');
    // if (state == screen) state = MyScreen.loading;
    // state = screen;
  }
}
