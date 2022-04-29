import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/view_layer/authenticate/reset_password_screen.dart';
import 'package:sepapka/view_layer/custom_widgets/app_loading.dart';
import 'package:sepapka/view_layer/question_list/question_list_filter.dart';
import 'package:sepapka/view_layer/question_list/question_list_single.dart';
import 'package:sepapka/view_layer/question_quiz/choose_cat_screen.dart';
import 'package:sepapka/view_layer/question_quiz/choose_level_screen.dart';
import 'package:sepapka/view_layer/question_list/question_list_screen.dart';
import 'package:sepapka/view_layer/question_quiz/question_quiz_single.dart';
import 'package:sepapka/view_layer/question_quiz/remark_screen.dart';
import 'package:sepapka/view_layer/question_quiz/session_finished_screen.dart';
import 'package:sepapka/view_layer/user_settings/debug_screen.dart';
import 'package:sepapka/view_layer/user_settings/settings_main_screen.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

import 'authenticate/sing_in_screen.dart';
import 'custom_widgets/dialog_message.dart';
import 'menu/menu_main_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    debugPrint('*** Wrapper built ***');

    //if there's a message in the manager, show the dialog


    return Selector<Manager, Screen>(
      selector: (_, manager) => manager.currentScreen,
      builder: (_, currentScreen, __) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
          switchOutCurve: const Threshold(0),
        // switchInCurve: Curves.easeIn,
        transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(
          key: key,
          child: child,
          opacity: animation,
          // position: Tween<Offset>(
          //   begin: const Offset(1, 0),
          //   end: Offset.zero,
          //.animate(animation),

          //animation.drive(Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease))),
        ),
        child: getWidget(currentScreen, context),
      ),
    );
  }


  Widget getWidget(Screen currentScreen, BuildContext context) {

    //if there's a message to show, do it
    String msg = context.read<Manager>().infoMsg;
    if (msg.isNotEmpty) WidgetsBinding.instance!.addPostFrameCallback((_)  => buildMessageDialog(context, msg));

    switch (currentScreen) {
      case Screen.loading:
        return const LoadingScreen();
      case Screen.signIn:
        return SignInScreen();
      case Screen.menu:
        return MenuScreen();
      case Screen.resetPassword:
        return ResetPasswordScreen();
      case Screen.settings:
        return const SettingsScreen();
      case Screen.chooseLevel:
        return MenuChooseLevel();
      case Screen.quizQuestionSingle:
        return QuestionQuizSingle();
      case Screen.sessionFinished:
        return SessionFinished();
      case Screen.listQuestion:
        return QuestionListScreen();
      case Screen.remark:
        return RemarkScreen();
      case Screen.debug:
        return DebugScreen();
      case Screen.chooseCategory:
        return ChooseCategory();
      case Screen.listQuestionSingle:
        return QuestionListSingle();
      case Screen.listQuestionFilter:
        return QuestionListFilter();
    }
  }
}
