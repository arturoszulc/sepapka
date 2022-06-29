// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:sepapka/utils/consts/my_screens.dart';
// import 'package:sepapka/controllers/authenticate/reset_password_screen.dart';
// import 'package:sepapka/utils/custom_widgets/app_loading.dart';
// import 'package:sepapka/controllers/calculators/calc_power_three_phase.dart';
// import 'package:sepapka/controllers/calculators/calculators_menu.dart';
// import 'package:sepapka/controllers/knowledge_base/academy_menu.dart';
// import 'package:sepapka/controllers/knowledge_base/tables/table_units.dart';
// import 'package:sepapka/controllers/knowledge_base/tables/table_wire_symbols.dart';
// import 'package:sepapka/controllers/purchase/purchase_error_screen.dart';
// import 'package:sepapka/controllers/purchase/purchase_patronite.dart';
// import 'package:sepapka/controllers/purchase/purchase_pending.dart';
// import 'package:sepapka/controllers/purchase/purchase_screen.dart';
// import 'package:sepapka/controllers/purchase/purchase_success_screen.dart';
// import 'package:sepapka/controllers/question_list/question_list_filter.dart';
// import 'package:sepapka/controllers/question_list/question_list_single.dart';
// import 'package:sepapka/controllers/question_quiz/choose_cat_screen.dart';
// import 'package:sepapka/controllers/question_quiz/choose_level_screen.dart';
// import 'package:sepapka/controllers/question_list/question_list_screen.dart';
// import 'package:sepapka/controllers/question_quiz/question_quiz_single.dart';
// import 'package:sepapka/controllers/question_quiz/remark_screen.dart';
// import 'package:sepapka/controllers/question_quiz/session_finished_screen.dart';
// import 'package:sepapka/controllers/user_settings/debug_screen.dart';
// import 'package:sepapka/controllers/user_settings/settings_main_screen.dart';
// import 'package:sepapka/viewmanager.dart';
//
// import 'authenticate/sing_in_screen.dart';
// import '../../utils/custom_widgets/dialog_message.dart';
// import 'knowledge_base/tables/table_wire_ampacity.dart';
// import 'knowledge_base/tables/table_wire_colors.dart';
// import 'menu/menu_main_screen.dart';
//
// class Wrapper extends StatelessWidget {
//   const Wrapper({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     debugPrint('*** Wrapper built ***');
//
//     //if there's a message in the manager, show the dialog
//
//
//
//
//
//
//
//
//
//
//     return Selector<Manager, MyScreen>(
//       selector: (_, manager) => manager.currentScreen,
//       builder: (_, currentScreen, __) => AnimatedSwitcher(
//         duration: const Duration(milliseconds: 200),
//           switchOutCurve: const Threshold(0),
//         // switchInCurve: Curves.easeIn,
//         transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(
//           key: key,
//           child: child,
//           opacity: animation,
//           // position: Tween<Offset>(
//           //   begin: const Offset(1, 0),
//           //   end: Offset.zero,
//           //.animate(animation),
//
//           //animation.drive(Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.ease))),
//         ),
//         child: getWidget(currentScreen, context),
//       ),
//     );
//   }
//
//
//   Widget getWidget(MyScreen currentScreen, BuildContext context) {
//
//     //if there's a message to show, do it
//     String msg = context.read<Manager>().infoMsg;
//     if (msg.isNotEmpty) WidgetsBinding.instance.addPostFrameCallback((_)  => buildMessageDialog(context, msg));
//
//     switch (currentScreen) {
//       case MyScreen.loading:
//         return const LoadingScreen();
//       case MyScreen.signIn:
//         return SignInScreen();
//       case MyScreen.menu:
//         return const MenuScreen();
//       case MyScreen.resetPassword:
//         return ResetPasswordScreen();
//       // case MyScreen.settings:
//       //   return const SettingsScreen();
//       case MyScreen.chooseLevel:
//         return const MenuChooseLevel();
//       case MyScreen.quizQuestionSingle:
//         return QuestionQuizSingle();
//       case MyScreen.sessionFinished:
//         return SessionFinished();
//       case MyScreen.listQuestion:
//         return QuestionListScreen();
//       case MyScreen.remark:
//         return RemarkScreen();
//       case MyScreen.debug:
//         return DebugScreen();
//       case MyScreen.chooseCategory:
//         return ChooseCategory();
//       case MyScreen.listQuestionSingle:
//         return QuestionListSingle();
//       case MyScreen.listQuestionFilter:
//         return QuestionListFilter();
//       case MyScreen.purchase:
//         return PurchaseScreen();
//       case MyScreen.purchaseError:
//         return PurchaseError();
//       case MyScreen.purchaseSuccess:
//         return PurchaseSuccess();
//       case MyScreen.purchasePending:
//         return PurchasePending();
//       case MyScreen.knowledgeBase:
//         return const KnowledgeBaseMenu();
//       case MyScreen.tableWireColors:
//         return const WireColors();
//       case MyScreen.tableWireAmpacity:
//         return WireAmpacity();
//       case MyScreen.tableWireSymbols:
//       return WireSymbols();
//       case MyScreen.calcMenu:
//         return const CalculatorsMenuScreen();
//         break;
//       case MyScreen.calcHeatingPowerThreePhase:
//         return CalcHeatingPowerThreePhase();
//
//       case MyScreen.units:
//         return UnitsScreen();
//     }
//   }
// }
