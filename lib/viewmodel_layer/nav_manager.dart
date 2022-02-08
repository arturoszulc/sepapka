import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
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

  // LoggedUser? get loggedUser => _userService.loggedUser;
  Stream<LoggedUser?> get loggedUser => _userService.loggedUserStream;

  NavManager() {
    //on initialize, subscribe to stream that checks if user is logged in or not
    watchLoggedUser();
  }

  // methods deployed automatically after user signs in or signs out //
  watchLoggedUser() {
    loggedUser.listen((LoggedUser? user) {
      debugPrint('NavMagaer loggedUser.listen deployed');
      if (user != null) {
        debugPrint('NavManager got user');
        navigate(Screen.menu);
      }
      if (user == null) {
        debugPrint('NavManager got NULL user');
        navigate(Screen.signIn);
      }
      // notifyListeners();
    });
  }

  //Default navigation method

  navigate(Screen screen) {
    debugPrint('Navigating to: ${screen.toString()}');
    _currentScreen = screen;
    notifyListeners();
  }
}
