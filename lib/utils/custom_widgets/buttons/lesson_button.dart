
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../consts/my_screens.dart';


class LessonButton extends ConsumerWidget {
  const LessonButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.screen,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final MyScreen screen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8.0),
      child: ElevatedButton.icon(
        icon: Icon(icon),
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50)),
        onPressed: () => context.pushNamed(screen.name),
        //badgeNum > -1 - zmienić to na 0, jeśli przycisk ma być wyszarzony, gdy nie ma pytań
        label: Row(
          children: [
            Expanded(child: Text(label, textAlign: TextAlign.center,)),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}