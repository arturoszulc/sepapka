import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/nav.dart';


Widget buildSettingsMenu(bool isQuestionHidden) {
  return PopupMenuButton(
    icon: const Icon(Icons.settings),
    itemBuilder: (context) => [
      PopupMenuItem(
        onTap: isQuestionHidden ? () =>  context.read<Manager>().moveQuestionBackToShown() : () => context.read<Manager>().doNotShowThisQuestionAnymore(),
        child: isQuestionHidden ? const Text('Przywróć pytanie') : const Text('Nie pokazuj więcej tego pytania'),
      ),
      PopupMenuItem(
        onTap: () => context.read<Manager>().navigate(Screen.remark),
        child: const Text('Zgłoś uwagę do pytania'),
      ),
    ],
  );

}