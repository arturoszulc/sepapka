import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/services/database.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';

import '../../locator.dart';

class AuthService {

DatabaseService _databaseService = serviceLocator.get<DatabaseService>();
UserService _userService = serviceLocator.get<UserService>();


//  // sign in with e-mail and password

  Future signInEmail(String email, String password) async {
    String resultID = '';
    try {
      //mocking userID returned by AuthService
      if (email == 'test') {
        resultID = '123456';
      }
      else {
        return Failure(errorResponse: 'invalid email');
      }

      //mocking getUserData from DatabaseService

      var data = await _databaseService.getUserData(resultID);
      //mocking createUser from UserService

      if (data != null) {
        await _userService.createUser(data);
        var result = _userService.loggedUser;
      if (result != null) {
        return Success(object: 'User created successfully');
      }
      }
    } catch (e) {
      debugPrint('AuthService caught ERROR: ${e.toString()}');
      return Failure(errorResponse: 'Unknown AuthService error');
    }
  }


}