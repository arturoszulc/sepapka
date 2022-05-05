import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/utils/custom_widgets/settings_popupmenu.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';


import 'dialog_leave_session.dart';

Widget singleQuestionTopBar(BuildContext context) {
  debugPrint('*** singleQuestionTopBar build ***');
  return Row(
    // mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      //Exit session button
      Expanded(
        // flex: 2,
        child: IconButton(
          onPressed: () async {
            bool result = await leaveSessionDialog(context);
            if (result) {
              context.read<Manager>().interruptSession();
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
          percent: context.read<Manager>().progressPercentSession,
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: Colors.yellow,
        ),
      ),

      //Options button
      Expanded(
          // flex: 2,
          child: buildSettingsMenu()),
    ],
  );
}
