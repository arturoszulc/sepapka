import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts/errors_messages.dart';

class AuthService {
  //Properties
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  //Constructor - default
  AuthService();

  //Getters
  FirebaseAuth get auth => _auth;

  // register with e-mail and password

  Future<Object> registerWithEmailAndPassword(String email, String password) async {
    // Object valEmailResult = validateEmail(email);
    // if (valEmailResult is Failure) return valEmailResult;
    // Object valPasswordResult = validatePassword(password);
    // if (valPasswordResult is Failure) return valPasswordResult;
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
    // Object valEmailResult = validateEmail(email);
    // if (valEmailResult is Failure) return valEmailResult;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Success();
    } on FirebaseAuthException catch (e) {
      debugPrint('CODE');
      debugPrint(e.code);
      return Failure(getMessageFromErrorCode(e.code));
    }
  }

  // void _changePassword(String currentPassword, String newPassword) async {
  //   final user = await FirebaseAuth.instance.currentUser;
  //   final cred = EmailAuthProvider.credential(
  //       email: user.email, password: currentPassword);
  //
  //   user.reauthenticateWithCredential(cred).then((value) {
  //     user.updatePassword(newPassword).then((_) {
  //       //Success, do something
  //     }).catchError((error) {
  //       //Error, show something
  //     });
  //   }).catchError((err) {
  //
  //   });}

  // Object validateEmailAndPassword({String? email, String? password}) {
  //   //validate e-mail
  //   if (email != null) {
  //     Object valEmailResult = validateEmail(email);
  //     // if (email.isEmpty || !email.contains('@')) return Failure(errorValEmail);
  //   }
  //   //validate password
  //   if (password != null) {
  //     bool validated = validatePassword(password);
  //     if (!validated) {
  //       return Failure(errorValPassword);
  //     }
  //   }
  //   return Success();
  // }

  String getMessageFromErrorCode(String code) {
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Ten adres e-mail jest już zajęty. Spróbuj się zalogować";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Hasło nieprawidłowe";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "Nie znaleziono konta zarejestrowanego na podany adres e-mail";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "Użytkownik jest zablokowany";
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Tymczasowo zablokowano dostęp ze względu na zbyt częste próby logownia. Spróbuj później";
      case "too-many-requests":
        return "Tymczasowo zablokowano dostęp ze względu na zbyt częste próby logownia. Spróbuj później";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Nieprawidłowy adres e-mail";
      case "network-request-failed":
        return "Brak połączenia z internetem, spróbuj ponownie";
      default:
        return "Błąd logowania, spróbuj ponownie";
    }
  }

  // Constructor - only for test
  AuthService.mocked(arg) {
    _auth = arg;
  }
}
