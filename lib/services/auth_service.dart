import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sepapka/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts/errors_messages.dart';
import 'package:sepapka/controllers/app_state_controller.dart';


final authStateProvider = StreamProvider<User?>((ref) {
  log('^^^ authStateProvider initialized ^^^');
  return ref.watch(authServiceProvider).authStateChange;
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref);
});



class AuthService {
  //Properties
  final Ref _ref;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  //  This getter will be returning a Stream of User object.
  //  It will be used to check if the user is logged in or not.
  Stream<User?> get authStateChange => _auth.authStateChanges();

  //Constructor - default
  AuthService(this._ref) {
    log('^^^ authService initialized ^^^');
    watchAuthUser();
  }

  watchAuthUser() {
    authStateChange.listen((User? user) async {
      if (user != null) {
        log('/// AuthService: User signed in ///');
        _ref.read(userService.notifier).getUserFromDb(user.uid);
      }
      if (user == null) {
        log('/// AuthService: User signed out ///');
        _ref.read(appStateNotifierProvider.notifier).userSignedOut();
        // _ref.read(routeController).navigate(MyScreen.signIn);
      }
    });
  }

  //Getters
  FirebaseAuth get auth => _auth;

  // register with e-mail and password

  Future<Object> registerWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).timeout(
            const Duration(seconds: 5),
          );
      return Success();
    } on FirebaseAuthException catch (e) {
      debugPrint('CODE');
      debugPrint(e.code);
      return Failure(getMessageFromErrorCode(e.code));
    } on TimeoutException {
      return Failure(errorNotInternetConnection);
    }
  }

  Future<Object> signInEmail(String email, String password) async {
    try {
      //get authUser
      await _auth.signInWithEmailAndPassword(email: email, password: password).timeout(
            const Duration(seconds: 5),
          );
      return Success();
    } on FirebaseAuthException catch (e) {
      debugPrint('CODE');
      debugPrint(e.code);
      return Failure(getMessageFromErrorCode(e.code));
    } on TimeoutException {
      return Failure(errorNotInternetConnection);
    }
  }

  Future<Object> signInGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      return Success();
    } catch (e) {
      debugPrint('GOOGLE SIGN IN ERROR: $e');
      return Failure(errorSignInGoogle);
    }
  }

  Future<Object> signOut() async {
    try {
      await _auth.signOut();
      return Success();
    } on FirebaseAuthException catch (e) {
      debugPrint('CODE');
      debugPrint(e.code);
      return Failure(getMessageFromErrorCode(e.code));
    }
  }

  Future<Object> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Success();
    } on FirebaseAuthException catch (e) {
      debugPrint('CODE');
      debugPrint(e.code);
      return Failure(getMessageFromErrorCode(e.code));
    }
  }

  String getMessageFromErrorCode(String code) {
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Ten adres e-mail jest ju?? zaj??ty. Spr??buj si?? zalogowa??";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Has??o nieprawid??owe";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "Nie znaleziono konta zarejestrowanego na podany adres e-mail";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "U??ytkownik jest zablokowany";
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Tymczasowo zablokowano dost??p ze wzgl??du na zbyt cz??ste pr??by logownia. Spr??buj p????niej";
      case "too-many-requests":
        return "Tymczasowo zablokowano dost??p ze wzgl??du na zbyt cz??ste pr??by logownia. Spr??buj p????niej";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Nieprawid??owy adres e-mail";
      case "network-request-failed":
        return "Brak po????czenia z internetem, spr??buj ponownie";
      default:
        return "B????d logowania, spr??buj ponownie";
    }
  }
  //
  // // Constructor - only for test
  // AuthService.mocked(arg) {
  //   _auth = arg;
  // }
}
