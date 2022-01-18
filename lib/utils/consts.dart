import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/models/question.dart';
import 'package:intl/intl.dart';

//Enums
enum QuestionStatus{noAnswer, rightAnswer, wrongAnswer }
enum QuestionType{newQuestion, practiceQuestion}

//Date related props
final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

//Question labels - to be rebuilt
const label1 = 'nowy';

//Button colors
const Color normalButtonColor = Colors.yellow;
const Color wrongButtonColor = Colors.redAccent;
Color rightButtonColor = Colors.green.shade500;

//LoggedUser model properties
const String userQVersion = 'qVersion';
const String userQListNew = 'qListNew';
const String userQListPractice = 'qListPractice';
const String userQListNotShown = 'qListNotShown';

//Question model properties
const String questionQ = 'q';
const String questionA1 = 'a1';
const String questionA2 = 'a2';
const String questionA3 = 'a3';
const String questionA4 = 'a4';
const String questionLabels = 'labels';
const String questionLevel = 'level';

Map<String, Color?> labelColors = {
  label1: Colors.blue,
};

const int questionVersionDB = 1;
const int questionVersionLocal = 0;

final questionListDB = [q5];

final Question q1 = Question(
  id: '',
  q: 'Question 1',
  a1: '1answer1',
  a2: '1answer2',
  a3: '1answer3',
  a4: '1answer4',
  labels: [],
  level: 1,
);

final Question q2 = Question(
  id: '',
  q: 'Question 2',
  a1: '2answer1',
  a2: '2answer2',
  a3: '2answer3',
  a4: '2answer4',
  labels: [],
  level: 1,
);

final Question q3 = Question(
  id: '',
  q: 'Question 3',
  a1: '3answer1',
  a2: '3answer2',
  a3: '3answer3',
  a4: '3answer4',
  labels: [],
  level: 1,
);

final Question q4 = Question(
  id: '',
  q: 'Question 4',
  a1: '4answer1',
  a2: '4answer2',
  a3: '4answer3',
  a4: '4answer4',
  labels: [],
  level: 1,
);
final Question q5 = Question(
  id: '',
  q: 'Question 5',
  a1: '5answer1',
  a2: '5answer2',
  a3: '5answer3',
  a4: '5answer4',
  labels: [],
  level: 1,
);

//////Errors

//DB Errors
const String errorGetQVersionFromDB = '### Nie udało się pobrać wersji pytań z bazy danych ###';
const String errorGetQListFromDB = '### Nie można pobrać listy pytań. Sprawdź połączenie z internetem ###';
const String errorGetUserDataFromDB = 'Błąd pobierania danych użytkownika. Sprawdź połączenie z internetem';
//AuthService Errors
const String errorSignIn = '### AuthService.signInEmail() error: ';

//FileManager error
const String errorWritingFile = '### FileService.saveQuestionListToFile() error: Couldnt write data to file ###';
const String errorReadingFile = '### FileService.getQuestionListFromFile() error: Couldnt read data from file ###';