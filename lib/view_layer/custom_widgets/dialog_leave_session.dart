import 'package:flutter/material.dart';


Future leaveSessionDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Czy na pewno chcesz przerwać sesję? Postępy nie zostaną zapisane.'),
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