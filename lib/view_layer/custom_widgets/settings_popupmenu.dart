import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';


Widget buildSettingsMenu() {
  return PopupMenuButton(
    icon: const Icon(Icons.settings),
    itemBuilder: (context) => [
      PopupMenuItem(
        onTap: () => context.read<Manager>().doNotShowThisQuestionAnymore(),
        child: const Text('Nie pokazuj więcej tego pytania'),
      ),
      PopupMenuItem(
        onTap: () => context.read<Manager>().sendQuestionRemarks(),
        child: const Text('Zgłoś uwagi do pytania'),
      ),
    ],
  );

}