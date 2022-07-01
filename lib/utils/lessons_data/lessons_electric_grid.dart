
import '../../utils/custom_widgets/layout/layout_custom_widgets.dart';


import '../../models/academy/unit_lesson_model.dart';

const Lesson gridLesson1 = Lesson(
  id: '1-1',
  title: 'Podstawy sieci',
  content: [
    LessonHeader(title: 'Informacje ogólne'),
    LessonParagraph(text: 'Sieci prądu przemiennego dzielimy na *jednofazowe* i *trójfazowe*.'),
    LessonParagraph(text: 'Oprócz przewodów fazowych, sieć może posiadać przewody: *neutralny*, *ochronny* lub *ochronno-neutralny*. Konfiguracja zależy od *typu sieci* z jakim mamy do czynienia.'),
    LessonHeader(title: 'Podstawowe typy sieci'),
    LessonParagraph(text: 'Obecnie stosowane typy sieci to *TN*, *IT* oraz *TT*. Sieci TN dzielą się dodatkowo na *TN-S*, *TN-C* i *TN-C-S*. Poszczególne litery odnoszą się do następujących francuskich określeń:'),
    CustomList(strings: [
      'T – terre – ziemia',
      'I – isolation – izolować',
      'N – neutre – neutralny',
      'S – separe  - oddzielny',
      'C – combine – połączony',
    ]),
    LessonParagraph(text: 'Znaczenie każdej z liter w kontekście budowy sieci przedstawiono poniżej.'),
    ImageCaption(path: 'assets/images/cables/przewod_ekranowany.png', caption: 'źródło: bitner.com', ignoreDarkMode: true,),
    LessonParagraph(text: 'Znaczenie każdej z liter w kontekście budowy sieci przedstawiono poniżej.'),

  ],
);