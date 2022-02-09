import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/model_layer/services/auth_service.dart';
import 'package:sepapka/model_layer/services/user_service.dart';
import 'package:sepapka/utils/consts/nav.dart';

import '../locator.dart';

class NavManager extends ChangeNotifier {
  //Services injection
  UserService _userService = serviceLocator.get<UserService>();


  //initial screen
  Screen _currentScreen = Screen.signIn;

  Screen get currentScreen => _currentScreen;

  //Streams
  // Stream<LoggedUser?> get loggedUser => _userService.loggedUserStreamController.stream;


  NavManager() {
    //on initialize, subscribe to stream that checks if user is logged in or not
    // watchAppState();
  }

  // methods deployed automatically after user signs in or signs out //
  // watchAppState() {
  //   debugPrint('NavManager.watchAppState() deployed');
  //   isLoading.listen((bool isLoading) {
  //   if (isLoading) navigate(Screen.loading);
  //   });
  //
  //   isGlobalDataReady.listen((bool isReady) {
  //     if (isReady) {
  //       debugPrint('NavManager got user');
  //       navigate(Screen.menu);
  //     }
  //     if (!isReady) {
  //       debugPrint('NavManager got NULL user');
  //       navigate(Screen.signIn);
  //     }
  //     // notifyListeners();
  //   }
  //
  //   );
  // }

  //Default navigation method

  // navigate(Screen screen) {
  //   debugPrint('Navigating to: ${screen.toString()}');
  //   _currentScreen = screen;
  //   notifyListeners();
  // }
}
