



import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model_layer/services/auth_service.dart';


final authError = StateProvider<String?>((ref) => null);


final authController =
Provider((ref) => AuthController(ref));

class AuthController {
  final Ref _ref;
  AuthController(this._ref) {
    // log('^^^ AuthController initialized ^^^');
  }

  Future<void> initState() async {
    final _authState = _ref.watch(authStateProvider);


  }





}