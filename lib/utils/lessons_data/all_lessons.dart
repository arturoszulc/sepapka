import 'package:flutter/material.dart';

import '../../models/academy/lesson_model.dart';
import 'lessons_cables.dart';


final List<Lesson> allLessons = [
  ...cableLessons,
  ...gridLessons,
];


const List<Lesson> cableLessons = [
  cableLesson1,
  Lesson(id: '2', title: 'lekcja 2', content: [Text('Lekcja 2')]),
  Lesson(id: '3', title: 'lekcja 3', content: [Text('Lekcja 3')]),
];

const List<Lesson> gridLessons = [
  Lesson(id: '4', title: 'lekcja 4', content: [Text('Lekcja 4')]),
  Lesson(id: '5', title: 'lekcja 5', content: [Text('Lekcja 5')]),
  Lesson(id: '6', title: 'lekcja 6', content: [Text('Lekcja 6')]),
];