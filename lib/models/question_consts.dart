import 'package:flutter/material.dart';
import 'package:sepapka/objects/question.dart';

const labelNew = 'nowy';
const labelKnown = 'znam';
const labelUnknown = 'nie znam';


Map<String, Color?> labelColors = {labelNew: Colors.white, labelKnown: Colors.yellow[50], labelUnknown: Colors.green[50]};


Question q1 = Question(
    id: '1',
    q: 'Jakie zadanie mają środki ochrony podstawowej w urządzeniach i instalacjach elektrycznych? ',
    a: 'Środki ochrony podstawowej mają uniemożliwić człowiekowi dotknięcia się czynnych części urządzeń i instalacji (tych przez które w ich normalnej pracy płynie prąd). ',
    labels: [labelNew]);

Question q2 = Question(
    id: '2',
    q: 'Czy wyłącznik różnicowoprądowy zadziała w sieci dwuprzewodowej? ',
    a: 'Jest zakaz stosowania wyłączników różnicowoprądowych przy braku przewodu ochronnego, muszą być min. 3 żyły. ',
    labels: [labelUnknown]);

Question q3 = Question(
    id: '3',
    q: 'Jaki kolor powinna mieć izolacja przewodu ochronnego w kablach i przewodach elektrycznych? ',
    a: 'Izolacja przewodu ochronnego powinna być koloru żółtego z zielonym paskiem wzdłuż',
    labels: [labelKnown]);

Question q4 = Question(
    id: '4',
    q: 'Jakie zadanie mają środki ochrony podstawowej w urządzeniach i instalacjach elektrycznych? ',
    a: 'Izolacja przewodu ochronnego powinna być koloru żółtego z zielonym paskiem wzdłuż',
    labels: [labelKnown]);

Question q5 = Question(
    id: '5',
    q: 'Czy wyłącznik różnicowoprądowy zadziała w sieci dwuprzewodowej? ',
    a: 'Jest zakaz stosowania wyłączników różnicowoprądowych przy braku przewodu ochronnego, muszą być min. 3 żyły. ',
    labels: [labelUnknown]);

Question q6 = Question(
    id: '6',
    q: 'Jaki kolor powinna mieć izolacja przewodu ochronnego w kablach i przewodach elektrycznych? ',
    a: 'Izolacja przewodu ochronnego powinna być koloru żółtego z zielonym paskiem wzdłuż',
    labels: [labelNew]);
