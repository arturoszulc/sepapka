import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sepapka/viewmodel_layer/manager.dart';

class MessageDialog extends StatelessWidget {
  final String msg;

  const MessageDialog({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      var result = await buildMessageDialog(context, msg);
      if (result) {
        //clear msg when dialog button is pressed
        context.read<Manager>().setMessage('');
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
      }
    });
    return Container();
  }
}

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
            Icon(
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
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
