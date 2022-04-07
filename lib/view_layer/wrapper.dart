import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/consts/nav.dart';
import 'package:sepapka/view_layer/authenticate/reset_password_screen.dart';
import 'package:sepapka/view_layer/authenticate/set_username_screen.dart';
import 'package:sepapka/view_layer/custom_widgets/app_loading.dart';
import 'package:sepapka/view_layer/question_list/question_list_filter.dart';
import 'package:sepapka/view_layer/question_list/question_list_single.dart';
import 'package:sepapka/view_layer/question_quiz/choose_cat_screen.dart';
import 'package:sepapka/view_layer/question_quiz/choose_level_screen.dart';
import 'package:sepapka/view_layer/question_list/question_list_screen.dart';
import 'package:sepapka/view_layer/question_quiz/question_quiz_single.dart';
import 'package:sepapka/view_layer/question_quiz/remark_screen.dart';
import 'package:sepapka/view_layer/ranking/user_ranking_screen.dart';
import 'package:sepapka/view_layer/question_quiz/session_finished_screen.dart';
import 'package:sepapka/view_layer/user_settings/change_user_data_screen.dart';
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

    //if there's message in manager, show dialog



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

  // void showMyDialog(BuildContext context, String msg) {
  //   debugPrint('theres message');
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       contentPadding: EdgeInsets.zero,
  //       content: Padding(
  //         padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           // mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Icon(
  //               Icons.info,
  //               color: Colors.blueAccent,
  //             ),
  //             Expanded(child: Padding(
  //               padding: const EdgeInsets.only(left: 8.0),
  //               child: Text(msg),
  //             )),
  //           ],
  //         ),
  //       ),
  //       // title: Row(
  //       //   children: [
  //       //     const Icon(Icons.info, color: Colors.blueAccent,),
  //       //     Text(message),
  //       //   ],
  //       // ),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             context.read<Manager>().setMessage('');
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget getWidget(Screen currentScreen, BuildContext context) {

    //if there's a message to show, do it
    String msg = context.read<Manager>().infoMsg;
    if (msg.isNotEmpty) WidgetsBinding.instance!.addPostFrameCallback((_)  => buildMessageDialog(context, msg));

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
      case Screen.setUsername:
        return SetUsernameScreen();
        break;
      case Screen.settings:
        return const SettingsScreen();
        break;
      case Screen.changeUserName:
        return ChangeUserData();
        break;
      case Screen.chooseLevel:
        return MenuChooseLevel();
        break;
      case Screen.quizQuestionSingle:
        return QuestionQuizSingle();
        break;
      case Screen.sessionFinished:
        return SessionFinished();
        break;
      case Screen.listQuestion:
        return QuestionListScreen();
        break;
      case Screen.userRank:
        return UserRankScreen();
        break;
      case Screen.remark:
        return RemarkScreen();
        break;
      case Screen.debug:
        return DebugScreen();
        break;

      case Screen.chooseCategory:
        return ChooseCategory();
        break;
      case Screen.listQuestionSingle:
        return QuestionListSingle();
        break;
      case Screen.listQuestionFilter:
        return QuestionListFilter();
        break;
    }
  }
}
