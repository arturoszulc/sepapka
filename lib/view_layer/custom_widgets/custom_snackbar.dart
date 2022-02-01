import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String errorMsg;

  const CustomSnackBar({Key? key, required this.errorMsg}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_){
      final snackBar = SnackBar(
        padding: const EdgeInsets.fromLTRB(15.0,15.0,0.0,15.0),
        content: Text(errorMsg),
        // action: SnackBarAction(
        //   label: 'Undo',
        //   onPressed: () {
        //     // Some code to undo the change.
        //   },
        // ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    return Container();
  }
}
