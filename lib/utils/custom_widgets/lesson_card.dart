import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/services/user_service.dart';

import '../../models/academy/unit_lesson_model.dart';

class LessonCard extends ConsumerWidget {
  const LessonCard({Key? key, required this.lesson, this.proOnly = false, required this.onTap})
      : super(key: key);

  final Lesson lesson;
  final bool proOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isUserPro = ref.read(userService).isPro;
    return Card(
      elevation: proOnly ? isUserPro ? 3 : 1 : 3,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(10.0),
        title: Text(
          lesson.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        subtitle: Text(
          lesson.id,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
