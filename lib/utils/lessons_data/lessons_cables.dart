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
    customBullets: ['oszczędne', 'bezpieczne','wytrzymałe'],
    strings: [
      'czyli nie nagrzewały się i nie marnowały w ten sposób energii elektrycznej,',
      'nie chcemy by parzenie kawy i suszenie włosów suszarką wzbudzały w nas strach, ',
      'prucie każdego roku ścian i układanie nowej instalacji byłoby bardzo problematyczne.',
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
  LessonParagraph(text: 'Poszczególne elementy przewodu zostały dokładnie opisane w kolejnych lekcjach.'),

]);


const Lesson cableLesson2 = Lesson(
    id: 'PE-2',
    title: 'Żyła przewodu',
    description: 'O materiałach, przekrojach i właściwościach żył',
    content: [
      LessonHeader(title: 'Materiał żył'),
      LessonParagraph(text: 'Żyła przewodu jest *przewodnikiem*. Inaczej mówiąc *materiałem o niskiej rezystywności*. A mówiąc najprościej *metalem*.'),
      LessonParagraph(text: 'Najlepiej przewodzącym metalem jest *srebro*, ale ze względu na jego wysoką cenę żyły wykonuje się zwykle z *miedzi* i *aluminium*.'),
      LessonCard(
          isFunFact: true,
          text: 'Drogie przewodniki, takie jak srebro i złoto, mają wiele pożądanych zalet. '
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
      LessonParagraph(text: 'W celu rozróżnienia poszczególnych konstrukcji, norma *IEC 60228* wprowadziła następujące oznaczenia:'),
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
      LessonParagraph(text: 'Z racji że liczba i grubość drutów w żyle wpływa na jej giętkość, norma *IEC 60228* wprowadza 4 standardowe klasy giętkości:'),
      LessonList(
          customBullets: ['klasa 1', 'klasa 2', 'klasa 5', 'klasa 6'],
          strings: [
            'żyły jednodrutowe, sztywne (tzw. drut), do układania na stałe.\nPrzykłady: DY, H05V-U',
            'żyły wielodrutowe, sztywne (tzw. wielodrut), do układania na stałe.\nPrzykłady: LY, H05V-R',
            'żyły wielodrutowe, giętkie, z cienkich drutów (tzw. linka), do odbiorników ruchomych.\nPrzykłady: OWY, OMY, H05VV-F',
            'żyły wielodrutowe, bardzo giętkie, z bardzo cienkich drutów (tzw. linka giętka), do odbiorników ruchomych.\nPrzykłady: SMYp, H03VH-H',
          ]),
      LessonParagraph(text: 'U producentów przewodów znaleźć możemy szczegółowe tabele ukazujące liczbę drutów (i ich średnice) z jakich składają się przeowdy poszczególnych klas.'),
      LessonParagraph(text: 'Dla przykładu, przewód o przekroju 1,5 mm\u00b2 posiada'),
      LessonList(
          customBullets: ['klasa 1', 'klasa 2', 'klasa 5', 'klasa 6'],
          strings: [
            '1 drut o średnicy 1,38 mm',
            '7 drutów o średnicy 0,52 mm każdy',
            '30 drutów o średnicy 0,25 mm każdy',
            '84 drutów o średnicy 0,15 mm każdy',
          ]),
      LessonHeader(title: 'Przekroje żył'),
      LessonParagraph(text: 'Przyjęło się, by poszczególne grubości żył rozróżniać nie na podstawie ich średnicy, a *pola przekroju poprzecznego*. I tak przewody potocznie nazywane *jedynką*, *półtorówką*, czy *czwórką* odpowiadają przekrojom równym *1, 1,5 oraz 4 mm\u00b2*'),
      LessonParagraph(text: 'Polsce kupimy głównie przewody objęte normą europejską, a więc o przekrojach:'),
      LessonParagraph(text: '0,5; 0,75; 1; 1,5; 2,5; 4; 6; 10; 16; 25; 35; 50; 70; 95; 120; 150; 185; 240; 300; 400; 500; 630; 800; 1000 mm\u00b2'),
      LessonCard(
          isFunFact: true,
          text: 'Norma dopuszcza stosowanie innych przekrojów w przypadku specjalnych zastosowań.\nPrzykładem może być przekrój 0,34 mm\u00b2, popularny w technice pomiarowej i sprzęcie audio, czy przekrój 2000 mm\u00b2, stosowany w liniach wysokiego napięcia.'),
      LessonParagraph(text: 'Warto wiedzieć, że poza naszą europejską normą, na rynku znajdziemy też przewody opisane jako *AWG* (ang. American Wire Gauge).'),
      LessonParagraph(text: 'Jest to standard stosowany między innymi w USA oraz Wielkiej Brytanii. Jedyny problem jest taki, że nie da się go w prosty sposób przeliczyć na nasz szereg.'),
      LessonParagraph(text: 'To znaczy, że w standardzie AWG nie znajdziemy odpowiednika europejskiej żyły 2,5 mm\u00b2. Najbliżej będą w tym wypadku AWG13 (przekrój 2,62 mm\u00b2) lub AWG14 (przekrój 2,08 mm\u00b2).'),
      LessonParagraph(text: 'Mimo braku przełożenia co do przekroju żył, jesteśmy w stanie dobrać odpowiedniki AWG pod względem zbliżonej *obciążalności prądowej długotrwałej*. Nie musimy też robić tego sami, bo producenci przewodów przygotowali dla nas specjalne tabele. Do jednej z nich prowadzi poniższy przycisk:'),
      //DY = H05V-U - drut kl. 1
      //LY = H05V-R - linka sztywna kl. 2
      //LgY = H05V-K - linka giętka kl. 5
      //OWY, OMY = H05VV-F - linka giętka kl. 5
      //SMYp = H03VH-H - linka supergięka kl.6
      LessonButton(icon: Icons.table_chart_outlined, label: 'Przekroje przewodów', screen: MyScreen.table_wire_diameter),

    ]);



