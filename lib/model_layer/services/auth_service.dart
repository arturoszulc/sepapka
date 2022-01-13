import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/consts.dart';

import '../../locator.dart';

class AuthService {

  //Services injection
DatabaseService _databaseService = serviceLocator.get<DatabaseService>();
UserService _userService = serviceLocator.get<UserService>();

  //Other
final FirebaseAuth _auth = FirebaseAuth.instance;


  // register with e-mail and password

  Future<bool> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? authUser = result.user;

      //create new Local User
      await _userService.createUserLocal(userId: authUser!.uid);

    }
    catch(e) {
      return false;
    }
    return true;
  }

  // sign in with e-mail and password

  Future<bool> signInEmail(String email, String password) async {
    try {
      //get authUser
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? authUser = result.user;

      // getUserData from DatabaseService
      var userData = await _databaseService.getUserData(authUser!.uid);

      // createUser from UserService

      if (userData != null) {
        await _userService.createUserLocal(user: userData);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(errorSignIn + e.toString() + '###');
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      await _userService.logOutUser();
      return true;
    } catch (e) {
      debugPrint('SIGN OUT ERROR: ${e.toString()}');
      return false;
    }
  }


}