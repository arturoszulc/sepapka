import '../../models/academy/unit_lesson_model.dart';
import '../../utils/custom_widgets/layout/layout_custom_widgets.dart';

const Lesson gridLesson1 = Lesson(
  id: '2-1',
  title: 'Podstawy sieci',
  content: [
    LessonHeader(title: 'Informacje ogólne'),
    LessonParagraph(text: 'Sieci prądu przemiennego dzielimy na *jednofazowe* i *trójfazowe*.'),
    LessonParagraph(text: 'Oprócz przewodów fazowych (L), sieć może posiadać przewody: *neutralny (N)*, *ochronny (PE)* lub *ochronno-neutralny (PEN)*. '
        'W praktyce stosowane są sieci:'),
    CustomList(
        bullets: true,
        strings: [
      'jednofazowe dwuprzewodowe (L+N)',
      'jednofazowe dwuprzewodowe (L+PEN)',
      'jednofazowe trójprzewodowe (L+N+PE)',
      'trójfazowe trójprzewodowe (3\u00d7L)',
      'trójfazowe czteroprzewodowe (3\u00d7L+N)',
      'trójfazowe czteroprzewodowe (3\u00d7L+PE)',
      'trójfazowe czteroprzewodowe (3\u00d7L+PEN)',
      'trójfazowe pięcioprzewodowe (3\u00d7L+N+PE)',
    ]),
    LessonParagraph(text: 'Bardzo ważną rzeczą w przypadku sieci jest sposób połączenia z ziemią oraz występowanie (i sposób prowadzenia) przewodu ochronnego. O tym mówi nam *typ sieci*.'),
    LessonHeader(title: 'Podstawowe typy sieci'),
    LessonParagraph(
        text:
            'Ze względu na sposób połączenia sieci (i wszystkich elementów przewodzących) z ziemią, wyróżniamy sieci typu *TN*, *TT* oraz *IT*. '
                'Jeśli chodzi o przewód ochronny to takowy posiada tylko sieć *TN* i ze względu na sposób jego prowadzenia wyróżniamy typy *TN-S*, *TN-C* i *TN-C-S*.'),
    LessonCard(
        isImportant: true,
        text: 'Sieci typu *TT* oraz *IT* nie posiadają ,,fabrycznego" przewodu realizującego funkcję ochronną. '
        'W ich przypadku musimy o taki przewód zadbać sami na etapie tworzenia instalacji.'),
    LessonParagraph(text: ' Poszczególne litery odnoszą się do następujących francuskich określeń:'),
    CustomList(strings: [
      'T – terre – ziemia',
      'I – isolation – izolować',
      'N – neutre – neutralny',
      'S – separe  - oddzielny',
      'C – combine – połączony',
    ]),
    LessonParagraph(
        text: 'Znaczenie każdej z liter w kontekście budowy sieci przedstawiono poniżej.'),
    ImageCaption(
      path: 'assets/images/grid/grid_symbols.png',
    ),
  ],
);

const Lesson gridLesson2 = Lesson(
    id: '2-2',
    title: 'Sieci TN, TT oraz IT',
    content: [

    ]);
