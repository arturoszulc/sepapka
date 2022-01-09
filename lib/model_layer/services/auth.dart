import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/services/database.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';

import '../../locator.dart';

class AuthService {

DatabaseService _databaseService = serviceLocator.get<DatabaseService>();
UserService _userService = serviceLocator.get<UserService>();


//  // sign in with e-mail and password

  Future<bool> signInEmail(String email, String password) async {
    String resultID = '';
    try {
      //mocked userID returned from Firestore
      if (email == 'test1') {
        resultID = '123456';
      }
      else {
        debugPrint('signInEmail Error: No such user');
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


}