import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/services/database_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/consts.dart';

import '../../locator.dart';

class AuthService {

DatabaseService _databaseService = serviceLocator.get<DatabaseService>();
UserService _userService = serviceLocator.get<UserService>();


//  // sign in with e-mail and password

  Future<bool> signInEmail(String email, String password) async {
    String resultID = '';
    try {
      //mocked userID returned from Firestore
      if (email == 'test') {
        resultID = '123456';
      }
      else {
        debugPrint(errorSignIn);
        return false;
      }

      //mocking getUserData from DatabaseService

      var userData = await _databaseService.getUserData(resultID);
      //mocking createUser from UserService

      if (userData != null) {
        await _userService.createUser(userData);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('AuthService caught ERROR: ${e.toString()}');
      return false;
    }
  }

  Future<bool> signOut() async {
    await _userService.logOutUser();
    return true;
  }


}