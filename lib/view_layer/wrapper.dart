import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/model_layer/models/logged_user.dart';
import 'package:sepapka/view_layer/authenticate/reset_password_screen.dart';
import 'package:sepapka/view_layer/custom_widgets/app_loading.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/viewmodel_layer/nav_manager.dart';
import 'package:sepapka/utils/consts/nav.dart';


import 'authenticate/authenticate.dart';
import 'authenticate/sing_in_screen.dart';
import 'menu/menu_main_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('*** Wrapper built ***');

    return Selector<NavManager, Screen>(
          selector: (_, navManager) => navManager.currentScreen,
        builder: (_, currentScreen, __) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (
          Widget child,
              Animation<double> animation) => ScaleTransition(child: child, scale: animation),
          child: getWidget(currentScreen),
        ),

        // {
        //     switch (currentScreen) {
        //
        //       case Screen.loading:
        //         return const LoadingScreen();
        //         break;
        //       case Screen.signIn:
        //         return SignInScreen();
        //         break;
        //       case Screen.menu:
        //         return MenuScreen();
        //         break;
        //
        //       case Screen.resetPassword:
        //         return ResetPasswordScreen();
        //         break;
        //     }
        // },

      );

    // return Selector<Manager, bool>(
    //   selector: (_, manager) => manager.loading,
    //   builder: (_, loading, __) => loading == true ? const Loading() :
    //       Selector<Manager, LoggedUser?>(
    //     selector: (_, manager) => manager.loggedUser,
    //     builder: (_, loggedUser, __) =>
    //         loggedUser != null ? Menu() : Authenticate(),
    //   ),
    // );

  }

  Widget getWidget(Screen currentScreen) {
    switch (currentScreen) {

      case Screen.loading:
        return const LoadingScreen();
        break;
      case Screen.signIn:
        return SignInScreen();
        break;
      case Screen.menu:
        return MenuScreen();
        break;

      case Screen.resetPassword:
        return ResetPasswordScreen();
        break;
    };
  }
}
