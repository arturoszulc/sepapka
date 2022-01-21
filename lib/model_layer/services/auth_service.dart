import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/methods.dart';

class AuthService {
  //Properties
  FirebaseAuth _auth = FirebaseAuth.instance;

  //Constructor - default
  AuthService();

  //Getters
  FirebaseAuth get auth => _auth;

  // register with e-mail and password

  Future<Object> registerWithEmailAndPassword(String email, String password) async {
    Object validateResult = validateEmailAndPassword(email, password);
    if (validateResult is Failure) return validateResult;
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return Success();
    } on FirebaseAuthException catch (e) {
      debugPrint('CODE');
      debugPrint(e.code);
      return Failure(getMessageFromErrorCode(e.code));
    }
  }

  Future<Object> signInEmail(String email, String password) async {
    try {
      //get authUser
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return Success();
    } on FirebaseAuthException catch (e) {
      debugPrint('CODE');
      debugPrint(e.code);
      return Failure(getMessageFromErrorCode(e.code));
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      debugPrint('SIGN OUT ERROR: ${e.toString()}');
      return false;
    }
  }

  Object validateEmailAndPassword(String email, String password) {
    //validate e-mail
    if (email.isEmpty || !email.contains('@')) return Failure('Nieprawidłowy adres e-mail');

    //validate password
    bool validated = validatePassword(password);
    if (!validated) return Failure('Hasło musi zawierać: \n - co najmniej 8 znaków \n - co najmniej 1 cyfrę \n - co najmniej 1 znak specjalny');

    return Success();
  }

  String getMessageFromErrorCode(String code) {
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Ten adres e-mail jest już zajęty. Spróbuj się zalogować";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Hasło nieprawidłowe";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "Nie znaleziono konta z podanym adresem e-mail";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "Użytkownik jest zablokowany";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Tymczasowo zablokowano dostęp ze względu na zbyt częste próby logownia. Spróbuj później";
        break;
      case "too-many-requests":
        return "Tymczasowo zablokowano dostęp ze względu na zbyt częste próby logownia. Spróbuj później";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Nieprawidłowy adres e-mail";
        break;
      default:
        return "Błąd logowania, spróbuj ponownie";
        break;
    }
  }

  // Constructor - only for test
  AuthService.mocked(arg) {
    _auth = arg;
  }
}
