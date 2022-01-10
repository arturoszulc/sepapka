import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/models/question.dart';

//Enums
enum QuestionStatus{noAnswer, rightAnswer, wrongAnswer }
enum QuestionType{newQuestion, practiceQuestion}

//Question labels - to be rebuilt
const label1 = 'nowy';

//Button colors
const Color normalButtonColor = Colors.yellow;
const Color wrongButtonColor = Colors.redAccent;
Color rightButtonColor = Colors.green.shade500;



Map<String, Color?> labelColors = {
  label1: Colors.blue,
};

const int questionVersionDB = 1;
const int questionVersionLocal = 0;

final questionListDB = [q1, q2, q3, q4, q5, q6];

final Question q1 = Question(
  id: '1',
  q: 'Question 1 Question 1 Question 1 Question 1 Question 1 Question 1',
  a1: '1answer1 1answer1 1answer1 1answer1',
  a2: '1answer2',
  a3: '1answer3',
  a4: '1answer4',
  label: label1,
  level: 1,
);

final Question q2 = Question(
  id: '2',
  q: 'Question 2 Question 2 Question 2 Question 2 Question 2 Question 2',
  a1: '2answer1',
  a2: '2answer2',
  a3: '2answer3',
  a4: '2answer4',
  label: label1,
  level: 1,
);

final Question q3 = Question(
  id: '3',
  q: 'Question 3 Question 3 Question 3 Question 3 Question 3 Question 3',
  a1: '3answer1',
  a2: '3answer2',
  a3: '3answer3',
  a4: '3answer4',
  label: label1,
  level: 1,
);

final Question q4 = Question(
  id: '4',
  q: 'Question 4 Question 4 Question 4 Question 4 Question 4 Question 4',
  a1: '4answer1',
  a2: '4answer2',
  a3: '4answer3',
  a4: '4answer4',
  label: label1,
  level: 1,
);

final Question q5 = Question(
  id: '5',
  q: 'Question 5 Question 5 Question 5 Question 5 Question 5 Question 5',
  a1: '5answer1',
  a2: '5answer2',
  a3: '5answer3',
  a4: '5answer4',
  label: label1,
  level: 1,
);

final Question q6 = Question(
  id: '6',
  q: 'Question 6 Question 6 Question 6 Question 6 Question 6 Question 6',
  a1: '6answer1',
  a2: '6answer2',
  a3: '6answer3',
  a4: '6answer4',
  label: label1,
  level: 1,
);

//////Errors

//DB Errors
const String errorQVersion = '### Nie udało się pobrać wersji pytań z bazy danych ###';

//AuthService Errors
const String errorSignIn = '### AuthService.signInEmail() error: No such user found ###';

//FileManager error
const String errorWritingFile = '### FileService.saveQuestionListToFile() error: Couldnt write data to file ###';
const String errorReadingFile = '### FileService.getQuestionListFromFile() error: Couldnt read data from file ###';