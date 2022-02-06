import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/services/auth_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/consts/nav.dart';

import '../locator.dart';

class NavManager extends ChangeNotifier {

  //Services injection
  AuthService _authService = serviceLocator.get<AuthService>();
  UserService _userService = serviceLocator.get<UserService>();


  // Stream<User?> get authUser => _authService.auth.authStateChanges();

  //initial screen
  Screen _currentScreen = Screen.signIn;

  Screen get currentScreen => _currentScreen;

  NavManager() {
    //on initialize, subscribe to stream that checks if user is logged in or not
    // watchAuthUser();
  }

  // methods deployed automatically after user signs in or signs out //
  // watchAuthUser() {
  //   authUser.listen((User? user) async {
  //     if (user != null) {
  //       debugPrint('/// User signed in ///');
  //       navigate(Screen.menu);
  //     }
  //     if (user == null) {
  //       debugPrint('/// User signed out ///');
  //       navigate(Screen.signIn);
  //     }
  //     // setLoading(false);
  //   });
  // }


  navigate(Screen screen) {
    debugPrint('Navigating to: ${screen.toString()}');
    _currentScreen = screen;
    notifyListeners();
  }


}
