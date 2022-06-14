import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/my_screens.dart';


Widget buildSettingsMenu() {
  double appBarHeight = AppBar().preferredSize.height;
  return Consumer(
    builder: (context, ref, child) => PopupMenuButton(
      offset: Offset(0.0, appBarHeight),
      icon: const Icon(Icons.settings),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () async {
            await ref.read(manager).doNotShowThisQuestionAnymore();
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
          onTap: () => ref.read(manager).navigate(MyScreen.remark),
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