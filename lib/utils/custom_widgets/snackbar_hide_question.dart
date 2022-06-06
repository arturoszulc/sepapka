import 'package:flutter/material.dart';

SnackBar snackBarShowHide({required String msg}) {
  return SnackBar(
      duration: const Duration(milliseconds: 1500),
      behavior: SnackBarBehavior.floating,
      content: Text(msg));
}