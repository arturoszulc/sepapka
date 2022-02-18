import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:sepapka/utils/consts.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    this.proOnly = false,
    this.isUserPro = false,
    this.hasBadge = false,
    this.badgeNum = 0,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final bool proOnly;
  final bool isUserPro;
  final bool hasBadge;
  final int badgeNum;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Badge(
        // shape: (proOnly && !isUserPro) ? BadgeShape.square : BadgeShape.circle,
        badgeContent: (proOnly && !isUserPro) ? const Icon(Icons.lock, size: 12,) : Text(badgeNum.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        toAnimate: false,
        badgeColor: Colors.blue,
        showBadge: (hasBadge && badgeNum > 0) || (proOnly && !isUserPro) ? true : false,
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50)),
          onPressed:
          (!proOnly || (proOnly && isUserPro)) && (!hasBadge || (hasBadge && badgeNum > 0)) ? onPressed : null,
          child: Text(label),
        ),
      ),
    );
  }
}