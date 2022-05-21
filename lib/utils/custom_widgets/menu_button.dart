import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:sepapka/utils/consts/colors.dart';

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
        // position: BadgePosition.center(),
        shape: BadgeShape.square,
        borderRadius: BorderRadius.circular(8),
        badgeColor: Theme.of(context).colorScheme.secondary,
        badgeContent: (proOnly && !isUserPro) ? const Icon(Icons.lock, size: 12,) : Text(badgeNum.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
        ),
        toAnimate: false,
        // badgeColor: myComplementary,
        showBadge: (hasBadge && badgeNum > 0) || (proOnly && !isUserPro) ? true : false,
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50)),
          onPressed:
          //badgeNum > -1 - zmienić to na 0, jeśli przycisk ma być wyszarzony, gdy nie ma pytań
          (!proOnly || (proOnly && isUserPro)) && (!hasBadge || (hasBadge && badgeNum > 0)) ? onPressed : null,
          child: Text(label, textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}