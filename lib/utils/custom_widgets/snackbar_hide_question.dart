import 'package:flutter/material.dart';

SnackBar buildSnackBar({required String msg}) {
  return SnackBar(
      duration: const Duration(milliseconds: 1500),
      behavior: SnackBarBehavior.floating,
      content: Text(msg));
}