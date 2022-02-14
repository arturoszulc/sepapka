import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/nav.dart';


Widget buildSettingsMenu() {
  return PopupMenuButton(
    icon: const Icon(Icons.settings),
    itemBuilder: (context) => [
      PopupMenuItem(
        onTap: () => context.read<Manager>().doNotShowThisQuestionAnymore(),
        child: const Text('Nie pokazuj więcej tego pytania'),
      ),
      PopupMenuItem(
        onTap: () => context.read<Manager>().navigate(Screen.remark),
        child: const Text('Zgłoś uwagę do pytania'),
      ),
    ],
  );

}