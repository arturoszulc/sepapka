import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts.dart';

import '../../locator.dart';

class AuthService {
  //Services injection
  // DatabaseService _databaseService = serviceLocator.get<DatabaseService>();
  // UserService _userService = serviceLocator.get<UserService>();

  //Other
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // User? _user;

  //Getters
  FirebaseAuth get auth => _auth;
  // User? get user => _user;
  // Stream
  Stream<User?> get user => _auth.authStateChanges();

  someMethod(String? uid) {
    debugPrint('someMethod deployed');
  }

  // sign-in, get data from DB and create local User model
  // Future<Object> signInAndCreateLocalUser(String email, String password) async {
  //   //try to signIn
  //   Object result = await signInEmail(email, password);
  //
  //   if (result is Failure) {
  //     return result;
  //   }
  //   // then get user data by ID from DB
  //   if (result is String) {
  //     var userData = await _databaseService.getUserData(result);
  //     if (userData == null) return Failure(errorGetUserDataFromDb);
  //
  //   }
  //   return Success();
  // }

  // register with e-mail and password

  Future<bool> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      return false;
    }
    return true;
  }

  // sign in with e-mail and password

  Future<Object> signInEmail(String email, String password) async {
    try {
      //get authUser
      UserCredential result =
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
      case "ERROR_TOO_MANY_REQUESTS":
      case "too-many-requests":
        return "Tymczasowo zablokowano dostęp ze względu na zbyt częste próby logownia. Spróbuj później";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Błąd serwera, spróbuj później";
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
}
