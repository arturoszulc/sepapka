import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';
import 'package:sepapka/utils/consts/nav.dart';


Widget buildSettingsMenu() {
  return PopupMenuButton(
    icon: const Icon(Icons.settings),
    itemBuilder: (context) => [
      PopupMenuItem(
        onTap: () async => await context.read<Manager>().doNotShowThisQuestionAnymore(),
        child: Row(
          children: const [
            Icon(Icons.visibility_off),
            SizedBox(width: 10),
            Text('Ukryj pytanie'),
          ],
        ),
      ),
      PopupMenuItem(
        onTap: () => context.read<Manager>().navigate(Screen.remark),
        child: Row(
          children: const [
            Icon(Icons.message),
            SizedBox(width: 10),
            Text('Zgłoś uwagę'),
          ],
        ),
      ),
    ],
  );

}