import 'package:flutter/material.dart';

class Lesson {
  final String id;
  final String title;
  final List<Widget> content;

  const Lesson({required this.id, required this.title, required this.content});

  factory Lesson.empty() {
    return const Lesson(id: '0', title: '', content: [Center(child: Text('Nie znaleziono lekcji'))]);
  }

}