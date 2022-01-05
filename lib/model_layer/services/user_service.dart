import 'package:flutter/material.dart';
import 'package:sepapka/utils/api_status.dart';
import 'package:sepapka/utils/consts.dart';


class UserService {


  static Future<Object> getUser(String email, String password) async {
    try {
      //TODO: Make auth service implementation
      var result = 1;
      if (result == 1) return Success(response: '123456');

      return Failure(code: NO_USER, errorResponse: 'getUser try error');
    }
    catch (e) {
      return Failure(code: GET_USER_ERROR, errorResponse: 'getUser catched error');
    }
  }

  authUser(String email, String password) {
    debugPrint('UserService, authUser method deployed');
    return true;
  }

}