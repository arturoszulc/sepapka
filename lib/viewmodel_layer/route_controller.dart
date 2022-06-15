import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/consts/my_screens.dart';

final routerStateProvider = StateNotifierProvider<RouterState, MyScreen>((ref) {
  return RouterState();
});

class RouterState extends StateNotifier<MyScreen> {
  RouterState() : super(MyScreen.loading); // : super(MyScreen.loading);

  void navigate(MyScreen screen) {
    state = screen;
  }
}
