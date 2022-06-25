import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/utils/custom_widgets/settings_popupmenu.dart';
import 'package:sepapka/viewmodel_layer/quiz_controller.dart';
import 'package:sepapka/viewmodel_layer/route_controller.dart';


import '../../viewmodel_layer/manager.dart';
import 'dialog_leave_session.dart';

Widget singleQuestionTopBar(BuildContext context) {
  debugPrint('*** singleQuestionTopBar build ***');
  return Consumer(
    builder: (context, ref, child) =>
        Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //Exit session button
        Expanded(
          // flex: 2,
          child: IconButton(
              onPressed: () async {
                bool result = await leaveSessionDialog(context);
                if (result) {
                  ref.read(routeController).navigate(MyScreen.menu);
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
            linearStrokeCap: LinearStrokeCap.roundAll,
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
