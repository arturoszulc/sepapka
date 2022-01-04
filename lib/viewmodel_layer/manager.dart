import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/services/user_service.dart';

class Manager extends ChangeNotifier {


  //Services Initialization
  final UserService _userService = UserService();

  //Models
  LoggedUser? _loggedUser;


  //Getters
  LoggedUser? get loggedUser => _loggedUser;


  signIn({required String email, required String password}) {
    //TODO: Make auth service implementation

    var signInResult = _userService.authUser(email, password);
    if (signInResult == true) {
      setLoggedUser('123456');
      return true;
    } else {
      return false;
    }
  }

  setLoggedUser(String uid) {
    _loggedUser = LoggedUser(documentId: uid);
    notifyListeners();
  }
}
