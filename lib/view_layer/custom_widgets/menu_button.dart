import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    this.hasBadge = false,
    this.badgeNum = 0,
    required this.label,
    required this.onPressed,
  }) : super(key: key);


  final bool hasBadge;
  final int badgeNum;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Badge(
        badgeContent: Text(badgeNum.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        toAnimate: false,
        badgeColor: Colors.blue,
        showBadge: hasBadge && badgeNum > 0 ? true : false,
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50)),
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }
}