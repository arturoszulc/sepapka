import 'package:flutter/material.dart';


class Unit {
  final String id;
  final String title;
  final String description;
  final List<Lesson> lessons;

  const Unit({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
  });

  factory Unit.empty() {
    return const Unit(id: '0', title: '', description: '', lessons: []);
  }
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final List<Widget> content;

  const Lesson({required this.id, required this.title, required this.description, required this.content});

  factory Lesson.empty() {
    return const Lesson(id: '0', title: '', description: '', content: [Center(child: Text('Nie znaleziono lekcji'))]);
  }

}