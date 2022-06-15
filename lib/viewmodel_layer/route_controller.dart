import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/consts/my_screens.dart';
import 'package:flutter/material.dart';

final routerStateProvider = StateNotifierProvider<RouterState, MyScreen>((ref) {
  return RouterState();
});

class RouterState extends StateNotifier<MyScreen> {
  RouterState() : super(MyScreen.signIn); // : super(MyScreen.loading);

  void navigate(MyScreen screen) {
    debugPrint('@@@### RouterState.navigate deployed ###@@@');
    if (state == screen) state = MyScreen.loading;
    state = screen;
  }
}
