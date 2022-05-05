import 'package:flutter/material.dart';

import '../../utils/consts/errors_messages.dart';


Future leaveSessionDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text(msgLeaveSession),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(false);
          },
          child: const Text('Nie, zostaję'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(true);
          },
          child: const Text('Tak, wychodzę'),
        ),
      ],
    ),
  );
}