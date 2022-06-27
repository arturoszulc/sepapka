import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/utils/custom_widgets/snackbar_hide_question.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/viewmodel_layer/quiz_controller.dart';


Widget buildSettingsMenu() {
  double appBarHeight = AppBar().preferredSize.height;
  return Consumer(
    builder: (context, ref, child) => PopupMenuButton(
      offset: Offset(0.0, appBarHeight),
      icon: const Icon(Icons.settings),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () async {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ref.read(quizController).moveQuestionToHidden();
            ScaffoldMessenger.of(context)
                .showSnackBar(buildSnackBar(msg: 'Pytanie zostało ukryte'));
          },
          child: Row(
            children: const [
              Icon(Icons.visibility_off),
              SizedBox(width: 10),
              Text('Ukryj pytanie'),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () => context.pushNamed(MyScreen.remark.name),
          child: Row(
            children: const [
              Icon(Icons.message),
              SizedBox(width: 10),
              Text('Zgłoś uwagę'),
            ],
          ),
        ),
      ],
    ),
  );

}