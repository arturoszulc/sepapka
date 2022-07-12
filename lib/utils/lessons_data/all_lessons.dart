import 'package:sepapka/models/academy/unit_lesson_model.dart';
import 'package:sepapka/utils/lessons_data/lessons_grid.dart';

import 'lessons_cables.dart';

//List of units
const List<Unit> academyUnits = [
  cablesUnit,
  gridUnit,
];


const List<Unit> basics = [

];

// Units
const Unit cablesUnit = Unit(
    id: '1',
    title: 'Przewody elektryczne',
    description: '',
    lessons: cableLessons);

const Unit gridUnit = Unit(
    id: '2',
    title: 'Sieci i instalacje niskiego napięcia',
    description: 'Poznaj budowę, zastosowanie i właśności podstawowych sieci TN, TT oraz IT',
    lessons: gridLessons);





//List of Lessons in Units
const List<Lesson> cableLessons = [
  cableLesson1,
  cableLesson2,
];

const List<Lesson> gridLessons = [
  gridLesson1,
  gridLesson2,
  gridLesson3,
  gridLesson4,
];