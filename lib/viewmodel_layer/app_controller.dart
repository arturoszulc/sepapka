//
//
// import 'dart:developer';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../model_layer/services/auth_service.dart';
//
// enum AppState {
//   initializing,
//   initialized,
//   loggedIn,
// }
//
//
//
// final appController =
// Provider((ref) =>
//   AppController(ref)
// );
//
//
//
// class AppController {
//   final Ref _ref;
//   // final User? user;
//   AppController(this._ref) {
//     log('^^^ AppController initialized ^^^');
//   }
//
//   Future<void> init() async {
//     final _authState = _ref.watch(authStateProvider);
//     log('AuthState: ${_authState.value.toString()}');
//
//   }
//
// }