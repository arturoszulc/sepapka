import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/consts/my_screens.dart';
import 'package:flutter/material.dart';


final currentScreen = StateProvider<MyScreen>((ref) => MyScreen.signIn);


//the routerState only purpose is to notify GoRouter that screen was switched
final routerStateProvider = StateNotifierProvider<RouterState, bool>((ref) {
  return RouterState(ref);
});

class RouterState extends StateNotifier<bool> {
  RouterState(this._ref) : super(false); // : super(MyScreen.loading);

  final Ref _ref;

  void navigate(MyScreen screen) {
    _ref.read(currentScreen.notifier).state = screen;
    debugPrint('@@@### RouterState.navigate deployed ###@@@');
    // if (state == screen) state = MyScreen.loading;
    // state = screen;
    state = !state;
  }
}
