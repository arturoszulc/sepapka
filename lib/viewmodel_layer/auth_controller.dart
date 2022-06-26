



import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/model_layer/models/input_validation_model.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/viewmodel_layer/app_state_controller.dart';

import '../model_layer/services/auth_service.dart';
import '../model_layer/services/validation_service.dart';
import '../utils/api_status.dart';


final authErrorState = StateProvider<String>((ref) => '');
final authLoading = StateProvider<bool>((ref) => false);
final emailState = StateProvider<InputValidationModel>((ref) => const InputValidationModel(null, null));
final passwordState = StateProvider<InputValidationModel>((ref) => const InputValidationModel(null, null));
final emailRemindErrorState = StateProvider.autoDispose<String>((ref) => '');
final emailRemindSent = StateProvider.autoDispose<bool>((ref) => false);

final authController = Provider((ref) => AuthController(ref));

class AuthController {

  final Ref _ref;
  AuthController(this._ref) {
    log('^^^ AuthController initialized ^^^');
  }


  setAuthError(String? error) {
    _ref.read(authErrorState.notifier).state = error ?? '';
  }
  setEmailRemindError(String? error) {
    _ref.read(emailRemindErrorState.notifier).state = error ?? '';
  }

  void validateEmail(String val) {
    final InputValidationModel result = _ref.read(validationService).validateEmail(val);
    _ref.read(emailState.notifier).state = result;
  }

  void validatePassword(String val) {
    final InputValidationModel result = _ref.read(validationService).validatePassword(val);
    _ref.read(passwordState.notifier).state = result;
  }
  // bool get isEmailRemindValid => _ref.read(validationService).isEmailRemindValid(_ref.read(emailRemindState));
  bool get isEmailAndPasswordValid => _ref.read(validationService).isEmailAndPasswordValid(_ref.read(emailState), _ref.read(passwordState));


  signIn() async {
    final email = _ref.read(emailState).value.toString();
    final password = _ref.read(passwordState).value.toString();
    //start loading app
    _ref.read(appStateNotifierProvider.notifier).appLoading();
    //Try to sign in
    Object signInResult = await _ref.read(authServiceProvider).signInEmail(email.toLowerCase(), password);
    if (signInResult is Failure) {
      setAuthError(signInResult.errorString);
      _ref.read(appStateNotifierProvider.notifier).userSignedOut(); //signInError should be equal signing out
    }
    if (signInResult is Success) setAuthError(null);
  }

  register() async {
    final email = _ref.read(emailState).value.toString();
    final password = _ref.read(passwordState).value.toString();
    //start loading app
    _ref.read(appStateNotifierProvider.notifier).appLoading();
    //register user
    Object registerResult =
    await _ref.read(authServiceProvider).registerWithEmailAndPassword(email.toLowerCase(), password);
    if (registerResult is Failure) {
      setAuthError(registerResult.errorString);
      _ref.read(appStateNotifierProvider.notifier).userSignedOut(); //signInError should be equal signing out
    }
    if (registerResult is Success) setAuthError(null);
  }

  signInWithGoogle() async {
    Object signInGoogleResult = await _ref.read(authServiceProvider).signInGoogle();
    if (signInGoogleResult is Failure) {
      setAuthError(signInGoogleResult.errorString);
      _ref.read(appStateNotifierProvider.notifier).userSignedOut(); //signInError should be equal signing out
    }
    if (signInGoogleResult is Success) {
      _ref.read(appStateNotifierProvider.notifier).appLoading();
      setAuthError(null);
    }
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
  }
  resetPassword() async {
    final emailRemind = _ref.read(emailState).value.toString();
    Object remindResult = await _ref.read(authServiceProvider).resetPassword(emailRemind.toLowerCase());
    if (remindResult is Failure) {
      setEmailRemindError(remindResult.errorString);
    }
    if (remindResult is Success) {
      _ref.read(emailRemindSent.notifier).state = true;
      setEmailRemindError(null);
    }

  }

}