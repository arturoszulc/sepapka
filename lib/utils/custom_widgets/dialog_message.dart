import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';


Future buildMessageDialog(BuildContext context, String message) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.info,
              color: Colors.blueAccent,
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(message),
            )),
          ],
        ),
      ),
      // title: Row(
      //   children: [
      //     const Icon(Icons.info, color: Colors.blueAccent,),
      //     Text(message),
      //   ],
      // ),
      actions: [
        Consumer(
      builder: (context, WidgetRef ref, child) => TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('OK'),
          ),
        ),
      ],
    ),
  );
}
