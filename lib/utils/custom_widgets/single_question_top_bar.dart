import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/utils/custom_widgets/settings_popupmenu.dart';
import 'package:sepapka/controllers/quiz_controller.dart';


import 'dialog_leave_session.dart';

Widget singleQuestionTopBar(BuildContext context) {
  debugPrint('*** singleQuestionTopBar build ***');
  return Consumer(
    builder: (context, ref, child) =>
        Row(
      children: [
        //Exit session button
        Expanded(
          // flex: 2,
          child: IconButton(
              onPressed: () async {
                bool result = await leaveSessionDialog(context);
                if (result) {
                  context.goNamed(MyScreen.menu.name);
                }
              },
              icon: const Icon(Icons.clear),
            ),

        ),

        //Session progress bar
        Expanded(
          flex: 6,
          child: LinearPercentIndicator(
            alignment: MainAxisAlignment.center,
            width: MediaQuery.of(context).size.width * 0.6,
            animation: true,
            lineHeight: 10.0,
            animationDuration: 800,
            animateFromLastPercent: true,
            percent: ref.watch(quizPercentProgress),
            // linearStrokeCap: LinearStrokeCap.roundAll,
            barRadius: const Radius.circular(10.0),
            progressColor: Colors.yellow,
          ),
        ),

        //Options button
        Expanded(
            // flex: 2,
            child: buildSettingsMenu()),
      ],
    ),
  );
}
