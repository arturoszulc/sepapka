import 'package:flutter/material.dart';



//Enums

enum QuestionStatus { noAnswer, rightAnswer, wrongAnswer }
enum QuestionType { newQuestion, practiceQuestion }
enum QuestionFilter {alphabetical, allNew, allPractice, allNotShown, level1, level2, level3, labelName1,labelName2,labelName3,labelName4,}


//Fibonacci series
const List<int> fibSeries = [0, 1, 2, 3, 5, 8, 13, 21];

//Question labels - to be rebuilt

const String labelName1 = 'definicje';
const String labelName2 = 'sieci niskiego napięcia';
const String labelName3 = 'urządzenia elektryczne';
const String labelName4 = 'ochrona przeciwporażeniowa';

const Map<String, Color?> labelColors = {
  'definicje': Colors.blue,
  'sieci niskiego napięcia': Colors.green,
  'urządzenia elektryczne': Colors.red,
  'ochrona przeciwporażeniowa': Colors.purple,
};

const Map<String, Widget> qListIcons = {
  'new': Icon(Icons.hourglass_empty),
  'practice': Icon(Icons.hourglass_full),
  'notShown': Icon(Icons.not_interested),
};