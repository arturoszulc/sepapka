import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/models/appState.dart';
import 'package:sepapka/model_layer/services/auth_service.dart';

import '../model_layer/services/user_service.dart';

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

  void listenAuthChange() {
    _ref.read(authStateProvider.stream).listen((User? user) {

    });
  }

  void userSignedIn() {
    state = state.copyWith(isSignedIn: true);
  }

  void userSignedOut() {
    state = state.copyWith(isSignedIn: false);
  }

  void appInitialized() {
    //means userData has been prepared
    state = state.copyWith(appInitialized: true);
  }



}