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
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: onTap,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                Text(lesson.id, style: const TextStyle(fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(lesson.title, style: Theme.of(context).textTheme.headline6,),
                ),
                Text(lesson.description, style: Theme.of(context).textTheme.bodyMedium),
            ],
          )
        ),
              const Expanded(child: Icon(Icons.arrow_forward_ios),),
            ],
          ),
        ),
      ),
    );
  }
}
