import 'package:flutter/material.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/utils/custom_widgets/buttons/lesson_button.dart';
import 'package:sepapka/utils/custom_widgets/layout/lesson_image_text_row.dart';

import '../../models/academy/unit_lesson_model.dart';
import '../../utils/custom_widgets/layout/layout_custom_widgets.dart';

const Lesson cableLesson1 = Lesson(
    id: 'PE-1',
    title: 'Jak zbudowany jest przewód?',
    description: 'O tym jak i dlaczego zbudowane są przewody.',
    content: [
  LessonHeader(title: 'Informacje ogólne'),
  LessonParagraph(text: 'Przewody elektryczne służą do *przesyłania energii elektrycznej*. Stąd ważne, by były one:'),
  LessonList(
    bullets: true,
    strings: [
      'oszczędne - czyli nie nagrzewały się i nie marnowały w ten sposób energii elektrycznej,',
      'bezpieczne - nie chcemy aby parzenia kawy i suszenie włosów suszarką kojarzyło nam się wiecznie ze strachem, ',
      'wytrzymałe - wyobraź sobie, że co roku musiałbyś pruć ściany i układać nową instalację. No właśnie.',
    ],
  ),
  LessonHeader(title: 'Budowa'),
  LessonParagraph(text: 'Aby spełnić powyższe założenia, przewody elektryczne składają się zwykle z:'),
  ImageCaption(path: 'assets/images/cables/przewod_ekranowany.png', caption: 'źródło: bitner.com', ignoreDarkMode: true,),
  LessonList(
      numbers: true,
      strings: [
        'żyła - element przewodzący prąd (fachowo: część czynna)',
        'izolacja - powłoka otaczająca żyły. Chroni je przed zwarciem między sobą i korozją',
        'ekran - element chroniący przed zakłóceniami elektromagnetycznymi',
        'warstwy ochronne - dodatkowa powłoka, pancerz lub odzież, w zależności od potrzeb',
      ]),
  LessonParagraph(text: 'Poszczególne elementy przewodu zostały dokładnie opisane w kolejnych lekcja.'),

]);


const Lesson cableLesson2 = Lesson(
    id: 'PE-2',
    title: 'Żyła - serce każdego przewodu',
    description: 'O materiałach, przekrojach i właściwościach żył',
    content: [
      LessonHeader(title: 'Materiał żył'),
      LessonParagraph(text: 'Żyła przewodu jest *przewodnikiem*. Inaczej mówiąc *materiałem o niskiej rezystywności*. A mówiąc najprościej *metalem*.'),
      LessonParagraph(text: 'Najlepiej przewodzącym metalem jest *srebro*, ale ze względu na jego wysoką cenę żyły wykonuje się zwykle z *miedzi* i *aluminium*.'),
      LessonCard(text: 'Drogie przewodniki, takie jak srebro i złoto, mają wiele pożądanych zalet. '
          'Stąd żyły miedziane niekiedy posrebrza się lub pozłaca, by zmniejszyć ich rezystancję, osiągnąć odporność na wyższą temperaturę lub odporność na zakłócenia.'
      ),
      LessonHeader(title: 'Kształt żył'),
      LessonParagraph(text: 'Żyły przewodów stosowanych w instalacjach niskiego napięcia mają najczęściej przekrój *okręgu* lub wycinka okręgu, zwanego *sektorem*.'),
      ImageCaption(path: 'assets/images/cables/cable_circular_sector_shapes.png', ignoreDarkMode: true,),
      LessonParagraph(text: 'Zaletą przewodów z żyłami sektorowymi jest znacznie lepsze wykorzystanie dostępnej przestrzeni. '
          'Innymi słowy, porównując dwa przewody o takiej samej obciążalności prądowej, ten z żyłami sektorowymi będzie miał *mniejszą średnicę* i to mimo potrzeby zastosowania nieco grubszej izolacji.'),
      ImageCaption(path: 'assets/images/cables/cable_circular_vs_sector.png', ignoreDarkMode: true,),
      LessonHeader(title: 'Budowa żył'),
      LessonParagraph(text: 'Żyły wykonane z jednego, litego kawałka metalu (tzw. *jednodrutowe*) są podatne na złamania, stąd nie nadają się one do zasilania odbiorników ruchomych. '
          'Aby temu zaradzić, wprowadzono żyły skręcane z dużej ilości cienkich drucików (tzw. *wielodrutowe*).'),
      LessonParagraph(text: 'W celu rozróżnienia poszczególnych konstrukcji, norma IEC 60228 wprowadziła następujące oznaczenia:'),
      LessonImageTextRow(
        image: ImageCaption(path: 'assets/images/cables/cable_construction_re.png', ignoreDarkMode: true,),
        texts: [
        Text('RE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        Text('żyła okrągła, jednodrutowa', textAlign: TextAlign.center,)
      ],),
      LessonImageTextRow(
        image: ImageCaption(path: 'assets/images/cables/cable_construction_rm.png', ignoreDarkMode: true,),
        texts: [
          Text('RM', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          Text('żyła okrągła, wielodrutowa', textAlign: TextAlign.center,)
        ],),
      LessonImageTextRow(
        image: ImageCaption(path: 'assets/images/cables/cable_construction_rmc.png', ignoreDarkMode: true,),
        texts: [
          Text('RMC', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
          Text('żyła okrągła, wielodrutowa, skompresowana',)
        ],),
      LessonImageTextRow(
        image: ImageCaption(path: 'assets/images/cables/cable_construction_se.png', ignoreDarkMode: true,),
        texts: [
          Text('SE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          Text('żyła sektorowa, jednodrutowa', textAlign: TextAlign.center,)
        ],),
      LessonImageTextRow(
        image: ImageCaption(path: 'assets/images/cables/cable_construction_sm.png', ignoreDarkMode: true,),
        texts: [
          Text('SM', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
          Text('żyła sektorowa, wielodrutowa', textAlign: TextAlign.left,)
        ],),
      LessonHeader(title: 'Klasy żył'),

      LessonParagraph(text: 'Dostępne grubości, czyli *przekroje poprzeczne*, również są ustandaryzowane. Znajdziesz je w tabeli'),
      LessonButton(icon: Icons.table_chart_outlined, label: 'Przekroje przewodów', screen: MyScreen.table_wire_diameter),

    ]);

