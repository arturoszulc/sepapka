import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sepapka/models/app_state.dart';
import 'package:sepapka/services/auth_service.dart';


final appVersionProvider = FutureProvider<String>((ref) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
});

final appState = Provider<AppState>((ref) => AppState.initial());

final appStateController = Provider<AppStateController>((ref) {
  return AppStateController();
});

class AppStateController {


}

final appStateNotifierProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) => AppStateNotifier(ref));


class AppStateNotifier extends StateNotifier<AppState> {
  final Ref _ref;
  AppStateNotifier(this._ref) : super(AppState.initial());

  void init() {
    log('/// AppService: init() called ///');

    //on init initialize AuthService to monitor if user is signed in
    _ref.read(authServiceProvider);
  }

  void appLoading() {
    //set both to false, to imit loading app state
    state = state.copyWith(isLoading: true);
  }

  void userSignedIn() {
    state = state.copyWith(isLoading: false, isSignedIn: true, isSignedOut: false);
  }

  void userSignedOut() {
    state = state.copyWith(isLoading: false, isSignedIn: false, isSignedOut: true);
  }

  // void appInitialized() {
  //   //means all necessary data (like userData) has been prepared
  //   log('/// App initialized ///');
  //   state = state.copyWith(appInitialized: true);
  // }

  void signInError() {
    state = state.copyWith(signInError: true);
  }

  void quizFinished() {
    state = state.copyWith(isQuizFinished: true);
  }

  void quitQuiz() {
    state = state.copyWith(isQuizFinished: false);
  }



}