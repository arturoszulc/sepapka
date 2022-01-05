import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/api_status.dart';

class Manager extends ChangeNotifier {
  //Services Initialization
  // final UserService _userService = UserService();

  //Models
  LoggedUser? _loggedUser;

  //Other properties
  bool _loading = false;

  //Getters
  LoggedUser? get loggedUser => _loggedUser;

  bool get loading => _loading;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  signIn({required String email, required String password}) async {
    setLoading(true);
    var result = await UserService.getUser(email, password);
    if (result is Success) {
      debugPrint('SUCCESS response: ${result.response}');
      setLoggedUser(result.response as String);
    }
    if (result is Failure) {
      debugPrint('FAILURE response: ${result.errorResponse}');
    }
    setLoading(false);
  }

  setLoggedUser(String uid) {
    _loggedUser = LoggedUser(documentId: uid);
  }
}
