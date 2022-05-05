import 'package:flutter/material.dart';

import '../consts/colors.dart';


class SignInButton extends StatelessWidget {
  const SignInButton({Key? key, required this.onPressed, required this.label}) : super(key: key);


  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(myPrimary),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
