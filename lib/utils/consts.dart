import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/question.dart';


//Question labels - to be rebuilt
const labelNew = 'nowy';
const labelKnown = 'znam';
const labelUnknown = 'nie znam';

//Button colors
const Color normalButtonColor = Colors.yellow;
const Color wrongButtonColor = Colors.redAccent;
const Color rightButtonColor = Colors.lightGreenAccent;

const int questionVersionDB = 1;

Map<String, Color?> labelColors = {
  labelNew: Colors.white,
  labelKnown: Colors.yellow[50],
  labelUnknown: Colors.green[50]
};

final Question q1 = Question(
  id: '1',
  q: 'Question 1 Question 1 Question 1 Question 1 Question 1 Question 1',
  a1: '1answer1 1answer1 1answer1 1answer1',
  a2: '1answer2',
  a3: '1answer3',
  a4: '1answer4',
  labels: [labelKnown],
  level: 1,
);

final Question q2 = Question(
  id: '2',
  q: 'Question 2 Question 2 Question 2 Question 2 Question 2 Question 2',
  a1: '2answer1',
  a2: '2answer2',
  a3: '2answer3',
  a4: '2answer4',
  labels: [labelKnown],
  level: 1,
);

final Question q3 = Question(
  id: '3',
  q: 'Question 3 Question 3 Question 3 Question 3 Question 3 Question 3',
  a1: '3answer1',
  a2: '3answer2',
  a3: '3answer3',
  a4: '3answer4',
  labels: [labelKnown],
  level: 1,
);

final Question q4 = Question(
  id: '4',
  q: 'Question 4 Question 4 Question 4 Question 4 Question 4 Question 4',
  a1: '4answer1',
  a2: '4answer2',
  a3: '4answer3',
  a4: '4answer4',
  labels: [labelKnown],
  level: 1,
);

final Question q5 = Question(
  id: '5',
  q: 'Question 5 Question 5 Question 5 Question 5 Question 5 Question 5',
  a1: '5answer1',
  a2: '5answer2',
  a3: '5answer3',
  a4: '5answer4',
  labels: [labelKnown],
  level: 1,
);

final Question q6 = Question(
  id: '6',
  q: 'Question 6 Question 6 Question 6 Question 6 Question 6 Question 6',
  a1: '6answer1',
  a2: '6answer2',
  a3: '6answer3',
  a4: '6answer4',
  labels: [labelKnown],
  level: 1,
);

//Errors

const NO_USER = 100;
const GET_USER_ERROR = 101;
