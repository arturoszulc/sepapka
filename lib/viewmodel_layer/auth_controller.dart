



import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/models/input_validation_model.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/viewmodel_layer/app_state_controller.dart';
import 'package:sepapka/viewmodel_layer/route_controller.dart';

import '../model_layer/services/auth_service.dart';
import '../model_layer/services/validation_service.dart';
import '../utils/api_status.dart';


final authErrorState = StateProvider<String>((ref) => '');
final emailState = StateProvider<InputValidationModel>((ref) => const InputValidationModel(null, null));
final passwordState = StateProvider<InputValidationModel>((ref) => const InputValidationModel(null, null));

final authController = Provider((ref) => AuthController(ref));

class AuthController {

  final Ref _ref;
  AuthController(this._ref//this._authService, this._routeController,
      ) {
    log('^^^ AuthController initialized ^^^');
      // final _authState = _ref.watch(authStateProvider);
      // if (_authState.value == null) {
      //   _ref.read(routeController).navigate(MyScreen.signIn);
      // } else {
      //   _ref.read(routeController).navigate(MyScreen.menu);
      // }
  }


  setAuthError(String? error) {
    _ref.read(authErrorState.notifier).state = error ?? '';
  }

  void validateEmail(String val) {
    final InputValidationModel result = _ref.read(validationService).validateEmail(val);
    _ref.read(emailState.notifier).state = result;
  }

  void validatePassword(String val) {
    final InputValidationModel result = _ref.read(validationService).validatePassword(val);
    _ref.read(passwordState.notifier).state = result;
  }

  bool get isEmailAndPasswordValid => _ref.read(validationService).isEmailAndPasswordValid(_ref.read(emailState), _ref.read(passwordState));


  signIn() async {
    final email = _ref.read(emailState).value.toString();
    final password = _ref.read(passwordState).value.toString();
    //start loading app
    _ref.read(routeController).navigate(MyScreen.loading);
    //Try to sign in
    Object signInResult = await _ref.read(authServiceProvider).signInEmail(email.toLowerCase(), password);
    if (signInResult is Failure) {
      setAuthError(signInResult.errorString);
      _ref.read(routeController).navigate(MyScreen.signIn);
    }
    if (signInResult is Success) setAuthError(null);
  }

  register() async {
    // //start loading app
    // _ref.read(routeController).navigate(MyScreen.loading);
    // //register user
    // Object registerResult =
    // await _authService.registerWithEmailAndPassword(email.toLowerCase(), password);
    // if (registerResult is Failure) {
    //   setError(registerResult);
    //   _routeController.navigate(MyScreen.signIn);
    // }
    // if (registerResult is Success) {
    //   setError(null);
    // }
  }

  signInWithGoogle() async {
    // Object signInGoogleResult = await _authService.signInGoogle();
    // if (signInGoogleResult is Failure) {
    //   setError(signInGoogleResult);
    //   _routeController.navigate(MyScreen.signIn);
    // }
    // if (signInGoogleResult is Success) setError(null);
  }

  signOut() async {
    Object signOutResult = await _ref.read(authServiceProvider).signOut();
    if (signOutResult is Failure) {
      setAuthError(signOutResult.errorString);
    }
    //reset input data in Sign In Screen
    _ref.read(emailState.notifier).state = const InputValidationModel(null,null);
    _ref.read(passwordState.notifier).state = const InputValidationModel(null,null);
    //clear user
    _ref.read(userService.notifier).clearUser();
    //change appState
    _ref.read(appStateNotifierProvider.notifier).userSignedOut();
  }


}