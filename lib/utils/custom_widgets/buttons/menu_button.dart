import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/services/user_service.dart';


class MenuButton extends ConsumerWidget {
  const MenuButton({
    Key? key,
    this.proOnly = false,
    this.hasBadge = false,
    this.badgeNum = 0,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final bool proOnly;
  final bool hasBadge;
  final int badgeNum;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isUserPro = ref.watch(userService).isPro;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8.0),
      child: Badge(
        // position: BadgePosition.center(),
        shape: BadgeShape.square,
        borderRadius: BorderRadius.circular(8),
        badgeColor: Theme.of(context).colorScheme.secondary,
        badgeContent: (proOnly && !isUserPro) ? Icon(Icons.lock, size: 12, color: Theme.of(context).colorScheme.tertiaryContainer,) : Text(badgeNum.toString(),
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