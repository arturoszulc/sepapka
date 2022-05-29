import 'package:flutter/material.dart';



class SignInButton extends StatelessWidget {
  const SignInButton({Key? key, required this.onPressed, required this.label}) : super(key: key);


  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
