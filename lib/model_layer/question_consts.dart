import 'package:flutter/material.dart';
import 'package:sepapka/model_layer/question.dart';

const labelNew = 'nowy';
const labelKnown = 'znam';
const labelUnknown = 'nie znam';

const int questionVersionDB = 1;

Map<String, Color?> labelColors = {
  labelNew: Colors.white,
  labelKnown: Colors.yellow[50],
  labelUnknown: Colors.green[50]
};

Question q1 = Question(
    id: '1',
    q: 'Jakie zadanie mają środki ochrony podstawowej w urządzeniach i instalacjach elektrycznych? ',
    a1: '${q1.id}answer1',
    a2: '${q1.id}answer2',
    a3: '${q1.id}answer3',
    a4: '${q1.id}answer4',
    labels: [labelNew],
    level: 1);

Question q2 = Question(
  id: '2',
  q: 'Czy wyłącznik różnicowoprądowy zadziała w sieci dwuprzewodowej? ',
  a1: 'answer21',
  a2: 'answer22',
  a3: 'answer23',
  a4: 'answer24',
  labels: [labelUnknown],
  level: 1,
);

Question q3 = Question(
  id: '3',
  q: 'Jaki kolor powinna mieć izolacja przewodu ochronnego w kablach i przewodach elektrycznych? ',
  a1: 'answer31',
  a2: 'answer32',
  a3: 'answer33',
  a4: 'answer34',
  labels: [labelKnown],
  level: 1,
);

Question q4 = Question(
  id: '4',
  q: 'Jakie zadanie mają środki ochrony podstawowej w urządzeniach i instalacjach elektrycznych? ',
  a1: 'answer41',
  a2: 'answer42',
  a3: 'answer3',
  a4: 'answer4',
  labels: [labelKnown],
  level: 1,
);

Question q5 = Question(
    id: '5',
    q: 'Czy wyłącznik różnicowoprądowy zadziała w sieci dwuprzewodowej? ',
    a1: 'answer1',
    a2: 'answer2',
    a3: 'answer3',
    a4: 'answer4',
    labels: [labelUnknown],
    level: 1,
);

Question q6 = Question(
    id: '6',
    q: 'Jaki kolor powinna mieć izolacja przewodu ochronnego w kablach i przewodach elektrycznych? ',
  a1: 'answer1',
  a2: 'answer2',
  a3: 'answer3',
  a4: 'answer4',
  labels: [labelUnknown],
  level: 1,

);
