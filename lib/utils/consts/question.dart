import 'package:flutter/material.dart';



//Enums

enum QuestionStatus { noAnswer, rightAnswer, wrongAnswer }
// enum QuestionType { learning, quiz }
// enum FilterQuestion {all, shownOnly, notShownOnly}

//Lists
const List<String> qTypeList = ["wszystkie", "tylko widoczne", "tylko ukryte"];
const List<String> qLevelList = ["wszystkie", "poziom 1", "poziom 2", "poziom 3"];
const List<String> qCategoryList = ["wszystkie", "definicje", "ochrona przeciwporażeniowa", "sieci niskiego napięcia", "urządzenia elektryczne"];



//Fibonacci series
const List<int> fibSeries = [0, 1, 2, 3, 5, 8, 13, 21];

//Question labels - to be rebuilt

const String labelName1 = 'definicje';
const String labelName2 = 'sieci niskiego napięcia';
const String labelName3 = 'ochrona przeciwporażeniowa';
const String labelName4 = 'urządzenia elektryczne';

const List<Color?> labelColors = [Colors.grey, Colors.blue, Colors.green, Colors.red, Colors.purple];

const Map<String, Widget> qListIcons = {
  'new': Icon(Icons.hourglass_empty),
  'practice': Icon(Icons.hourglass_full),
  'notShown': Icon(Icons.visibility_off),
  'none': SizedBox(),
};