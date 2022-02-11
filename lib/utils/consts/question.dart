import 'package:flutter/material.dart';



//Enums

enum QuestionStatus { noAnswer, rightAnswer, wrongAnswer }
enum QuestionType { newQuestion, practiceQuestion }
enum QuestionFilter {alphabetical, allNew, allPractice, allNotShown, level1, level2, level3, label1,label2,label3,label4,}

//Fibonacci series
const List<int> fibSeries = [0, 1, 2, 3, 5, 8, 13, 21];

//Question labels - to be rebuilt
const String label1 = 'definicje';
const String label2 = 'sieci niskiego napięcia';
const String label3 = 'urządzenia elektryczne';
const String label4 = 'ochrona przeciwporażeniowa';

Map<String, Color?> labelColors = {
  'definicje': Colors.blue,
  'sieci niskiego napięcia': Colors.green,
  'urządzenia elektryczne': Colors.red,
  'ochrona przeciwporażeniowa': Colors.purple,
};