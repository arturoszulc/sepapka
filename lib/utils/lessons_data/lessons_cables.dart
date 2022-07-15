import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sepapka/utils/consts/my_screens.dart';
import 'package:sepapka/utils/consts/strings.dart';
import 'package:sepapka/utils/custom_widgets/buttons/lessonButtonLink.dart';
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
      'czyli nie nagrzewały się i nie marnowały w ten sposób energii elektrycznej.',
      'nie chcemy by parzenie kawy i suszenie włosów suszarką wzbudzały w nas strach. ',
      'prucie każdego roku ścian i układanie nowej instalacji byłoby bardzo problematyczne.',
    ],
  ),
  LessonHeader(title: 'Budowa'),
  LessonParagraph(text: 'Aby spełnić powyższe założenia, przewody elektryczne składają się zwykle z:'),
  ImageCaption(path: 'assets/images/cables/cable_construction.png', caption: 'źródło: bitner.com', ignoreDarkMode: true,),
  LessonList(
      numbers: true,
      strings: [
        'żyła - element przewodzący prąd (fachowo: część czynna),',
        'izolacja - powłoka otaczająca żyły. Chroni je przed zwarciem między sobą i korozją,',
        'ekran - element chroniący przed zakłóceniami elektromagnetycznymi,',
        'warstwy ochronne - dodatkowa powłoka, pancerz lub odzież, w zależności od potrzeb,',
      ]),
  LessonParagraph(text: 'Poszczególne elementy przewodu zostały dokładnie opisane w kolejnych lekcjach.'),

]);


const Lesson cableLesson2 = Lesson(
    id: 'PE-2',
    title: 'Żyła przewodu',
    description: 'O materiałach, przekrojach i właściwościach żył',
    content: [
      LessonHeader(title: 'Materiał żył'),
      LessonParagraph(text: 'Żyła przewodu jest *przewodnikiem*, czyli *materiałem o niskiej rezystywności*. Mówiąc najprościej: *metalem*.'),
      LessonParagraph(text: 'Najlepiej przewodzącym metalem jest *srebro*, ale ze względu na jego wysoką cenę, żyły wykonuje się zwykle z *miedzi* i *aluminium*.'),
      LessonCard(
          isFunFact: true,
          text: 'Srebro i złoto, mimo wysokiej ceny, posiadają wiele pożądanych cech. '
          'Stąd żyły miedziane niekiedy posrebrza się lub pozłaca, by zmniejszyć ich rezystancję, osiągnąć odporność na wyższą temperaturę lub odporność na zakłócenia.'
      ),
      LessonHeader(title: 'Kształt żył'),
      LessonParagraph(text: 'Żyły przewodów stosowanych w instalacjach niskiego napięcia mają najczęściej przekrój *okręgu* lub wycinka okręgu, zwanego *sektorem*.'),
      ImageCaption(path: 'assets/images/cables/cable_circular_sector_shapes.png', ignoreDarkMode: true,),
      LessonParagraph(text: 'Zaletą żył sektorowych jest znacznie lepsze wykorzystanie dostępnej przestrzeni w przewodzie wielożyłowym. Wadą jest konieczność stosowania nieco grubszej izolacji.'),
      LessonParagraph(text: 'Wspomniana wada nie zmienia faktu, że przewód sektorowy będzie miał *mniejszą średnicę*, od przewodu z żyłami okrągłymi o tej samej obciążalności prądowej.'),
      ImageCaption(path: 'assets/images/cables/cable_circular_vs_sector.png', ignoreDarkMode: true,),
      LessonHeader(title: 'Budowa żył'),
      LessonParagraph(text: 'Żyły wykonane z jednego, litego kawałka metalu (tzw. *jednodrutowe*) są podatne na złamania, stąd nie nadają się do zasilania odbiorników ruchomych. '
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
      LessonParagraph(text: 'Przewody wielodrutowe mogą być zbudowane z różnej liczby drucików (o różnej grubości), co wpływa na ich *elastyczność*. Stąd norma *IEC 60228* wprowadziła dodatkowy podział żył na 4 klasy giętkości:'),
      LessonList(
          customBullets: ['klasa 1', 'klasa 2', 'klasa 5', 'klasa 6'],
          strings: [
            'żyły jednodrutowe, sztywne (tzw. drut), do układania na stałe.\nPrzykłady: DY, H05V-U',
            'żyły wielodrutowe, sztywne (tzw. wielodrut), do układania na stałe.\nPrzykłady: LY, H05V-R',
            'żyły wielodrutowe, giętkie, z cienkich drutów (tzw. linka), do odbiorników ruchomych.\nPrzykłady: OWY, OMY, H05VV-F',
            'żyły wielodrutowe, bardzo giętkie, z bardzo cienkich drutów (tzw. linka giętka), do odbiorników ruchomych.\nPrzykłady: SMYp, H03VH-H',
          ]),
      LessonParagraph(text: 'U producentów przewodów znaleźć możemy szczegółowe tabele prezentujące liczbę i średnicę drutów z jakich składają się przewody poszczególnych klas.'),
      LessonParagraph(text: 'Dla przykładu, wartości te dla przewodu o przekroju 1,5 mm\u00b2 prezentują się następująco:'),
      LessonList(
          customBullets: ['klasa 1', 'klasa 2', 'klasa 5', 'klasa 6'],
          strings: [
            '1 drut o średnicy 1,38 mm',
            '7 drutów o średnicy 0,52 mm każdy',
            '30 drutów o średnicy 0,25 mm każdy',
            '84 drutów o średnicy 0,15 mm każdy',
          ]),
      LessonHeader(title: 'Przekroje żył'),
      LessonParagraph(text: 'Najważniejszą cechą każdej żyły jest *pole przekroju poprzecznego*. Im jest ono wyższe, tym większy prąd jest w stanie wytrzymać żyła.'),
      LessonParagraph(text: 'Europejska norma *IEC 60228* obejmuje również ten aspekt i tak u producentów znajdziemy przewody o następujących przekrojach żył:'),
      LessonParagraph(text: '0,5; 0,75; 1; 1,5; 2,5; 4; 6; 10; 16; 25; 35; 50; 70; 95; 120; 150; 185; 240; 300; 400; 500; 630; 800; 1000 mm\u00b2'),
      LessonCard(
          isFunFact: true,
          text: 'Norma dopuszcza stosowanie innych przekrojów w przypadku specjalnych zastosowań.\nPrzykładem może być przekrój 0,34 mm\u00b2, popularny w technice pomiarowej i sprzęcie audio, czy przekrój 2000 mm\u00b2 stosowany w liniach wysokiego napięcia.'),
      LessonParagraph(text: 'Warto wiedzieć, że na rynku możemy spotkać również przewody opisane jako *AWG* (ang. American Wire Gauge). Jest to standard stosowany między innymi w USA oraz Wielkiej Brytanii.'),
      LessonParagraph(text: 'Niestety nie da się go w prosty sposób przeliczyć na nasz europejski szereg. To znaczy, że w standardzie AWG nie znajdziemy odpowiednika europejskiej żyły 2,5 mm\u00b2. Najbliżej będą w tym wypadku AWG13 (przekrój 2,62 mm\u00b2) lub AWG14 (przekrój 2,08 mm\u00b2).'),
      LessonParagraph(text: 'Stąd, chcąc dobrać zamiennik w szeregu AWG, zawsze wybieramy ten o nieco większym przekroju. Wtedy mamy pewność, że wytrzyma on *co najmniej taki sam prąd*. Zgodnie z tą zasadą, szukają odpowiednikeim żyły 2,5 mm\u00b2 powinniśmy wybrać AWG13.'),
      LessonParagraph(text: 'Jeśli nie chce nam się szukać i porównywać przekrojów w obu szeregach, możemy skorzystać z gotowych tabel udostępnionych przez producentów przewodów. Do jednej z nich prowadzi poniższy przycisk:'),
      LessonButton(icon: Icons.table_chart_outlined, label: 'Przekroje przewodów', screen: MyScreen.table_wire_diameter),

    ]);


const Lesson cableLesson3 = Lesson(
    id: 'PE-3',
    title: 'Izolacja żył',
    description: 'O rodzajach i właściwościach izolacji przewodów',
    content: [
      LessonHeader(title: 'Cel izolacji'),
      LessonParagraph(text: 'Izolacja żył stosowana jest w celu:'),
      LessonList(
          bullets: true,
          strings: [
            'oddzielenia żył przewodu od siebie, by nie doszło do zwarcia,',
            'ochrony żył przed wpływem wilgoci i środków chemicznych,',
            'ochrony człowieka przed dotknięciem żyły i porażeniem.',
          ]),
      LessonCard(
          isImportant: true,
          text: 'Izolacja żyły jest pierwszą linią ochrony przed porażeniem prądem elektrycznym. '
              'W teorii ochrony przeciwporażeniowej zaliczamy ją do środków ochrony podstawowej (czyli przed dotykiem bezpośrednim).'),
      LessonHeader(title: 'Materiały izolacji'),
      LessonParagraph(text: 'Do najpopularniejszych materiałów stosowanych jako izolacje przewodów, należą:'),
      LessonList(
          bullets: true,
          strings: [
            'polwinit (PVC, PCW)',
            'polietylen (PE)',
            'polietylen spieniony (Foam PE)',
            'polietylen usieciowany (XLPE)',
            'elastomery termoplastyczne (TPE)',
            'tworzywa bezhalogenowe (HFFR)',
            'gumy',
          ]),

      LessonHeader(title: 'Polwinit (PVC, PCW)'),
      LessonParagraph(text: 'Zastosowanie:'),
      LessonList(
          bullets: true,
          strings: [
            'instalacje elektryczne do 1 kV',
          ]),
      LessonParagraph(text: 'Zalety:'),
      LessonList(
          bullets: true,
          strings: [
            'tani',
            'nie rozprzestrzenia płomienia',
            'odporny na oleje, ozon, promieniowanie UV i większość rozpuszczalników',
          ]),
      LessonParagraph(text: 'Wady:'),
      LessonList(
          bullets: true,
          strings: [
            'niezbyt wysoka wytrzymałość elektryczna (maks. 1 kV)',
            'maksymalna temperatura pracy to 70\u00b0C',
            'twardnieje w niskich temperaturach',
            'podczas pożaru wydziela gęsty, trujący dym',
          ]),
      LessonCard(
          isImportant: true,
          text: 'Polwinit to plastyfikwoany polichlorek winylu, którego skrót to PVC lub PCW. Określenie PCV jest niepoprawne i nie należy go używać.'),


      LessonHeader(title: 'Polietylen (PE)'),
      LessonParagraph(text: 'Zastosowanie:'),
      LessonList(
          bullets: true,
          strings: [
        'instalacje elektryczne powyżej 1 kV',
        'transmisja danych',
      ]),
      LessonParagraph(text: 'Zalety:'),
      LessonList(
          bullets: true,
          strings: [
            'lekki',
            'odporny na działanie wody i większości związków chemicznych',
            'bardziej wytrzymały elektrycznie niż PVC (powyżej 1 kV)',
            'mniej podatny na zakłócenia niż PVC (mniejsza pojemność elektryczna)',
          ]),
      LessonParagraph(text: 'Wady:'),
      LessonList(
          bullets: true,
          strings: [
            'nie lubi UV',
            'łatwopalny',
            'podczas pożaru skapują z niego płonące krople',
          ]),

      LessonHeader(title: 'Polietylen spieniony (Foam PE)'),
      LessonParagraph(text: 'Zastosowanie:'),
      LessonList(
          bullets: true,
          strings: [
            'transmisja danych wysokich częstotliwości (przewody koncentryczne)',
          ]),
      LessonParagraph(text: 'Zalety:'),
      LessonList(
          bullets: true,
          strings: [
            'mniej podatny na zakłócenia niż PE',
            'odporność na wnikanie wody',
          ]),
      LessonParagraph(text: 'Wady:'),
      LessonList(
          bullets: true,
          strings: [
            'niska wytrzymałość mechaniczna',
          ]),


      LessonHeader(title: 'Polietylen usieciowany (XLPE)'),
      LessonParagraph(text: 'Zastosowanie:'),
      LessonList(
          bullets: true,
          strings: [
            'kable energetyczne',
          ]),
      LessonParagraph(text: 'Zalety:'),
      LessonList(
          bullets: true,
          strings: [
            'wysoka odporność na temperaturę (90\u00b0C)',
            'wysoka wytrzymałość elektryczna i mechaniczna',
            'niepalny',
            'odporny na większość związków chemicznych, UV i warunki atmosferyczne',
          ]),
      LessonParagraph(text: 'Wady:'),
      LessonList(
          bullets: true,
          strings: [
            'cena',
            'z powodu starzenia, do wnętrza może wnikać woda (wolna od tej wady jest odmiana XLPE, zwana XLVLDPE), '
          ]),



      LessonHeader(title: 'elastomery termoplastyczne (TPE)'),
      LessonParagraph(text: 'Zastosowanie:'),
      LessonList(
          bullets: true,
          strings: [
            'wszędzie tam, gdzie panują agresywne warunki i wymagana jest wysoka czystość (np. przemysł spożywczy)',
          ]),
      LessonParagraph(text: 'Zalety:'),
      LessonList(
          bullets: true,
          strings: [
            'odporny na temperaturę w zakresie -50\u00b0C \u00F7 90\u00b0C',
            'elastyczny',
            'niepalny',
            'łatwy w czyszczeniu',
            'odporny na większość związków chemicznych, UV, warunki atmosferyczne, a nawet czyszczenie parą',
          ]),
      LessonParagraph(text: 'Wady:'),
      LessonList(
          bullets: true,
          strings: [
            'cena',
            'ulega deformacji pod wpływem zbyt wysokiej temperatury i ciśnienia',
          ]),


      LessonHeader(title: 'tworzywa bezhalogenowe (HFFR)'),
      LessonParagraph(text: 'Zastosowanie:'),
      LessonList(
          bullets: true,
          strings: [
            'miejsca zagrożone pożarem/wybuchem, miejsca publiczne',
          ]),
      LessonParagraph(text: 'Zalety:'),
      LessonList(
          bullets: true,
          strings: [
            'takie jak polwinit + brak trującego dymu w czasie pożaru',
          ]),
      LessonParagraph(text: 'Wady:'),
      LessonList(
          bullets: true,
          strings: [
            'niska odporność na większość czynników agresywnych (np. kwasów)',
          ]),


      LessonHeader(title: 'gumy'),
      LessonParagraph(text: 'Zastosowanie:'),
      LessonList(
          bullets: true,
          strings: [
            'odbiorniki ruchome, również narażone na skrajne temperatury (np. żelazko)',
          ]),
      LessonParagraph(text: 'Zalety:'),
      LessonList(
          bullets: true,
          strings: [
            'odporne na bardzo wysokie temperatury (guma silikonowa nawet 180\u00b0C)',
                'elastyczne w każdej temperaturze',
            'ognioodporne',
          ]),
      LessonParagraph(text: 'Wady:'),
      LessonList(
          bullets: true,
          strings: [
            'wrażliwe na UV i chemię ropopochodną (np. benzynę)',
            'ulegają starzeniu',
          ]),
]);


const Lesson cableLesson4 = Lesson(
    id: 'PE-4', 
    title: 'Warstwy zewnętrzne',
    description: 'O ekranie, powłoce, odzieży i pancerzu',
    content: [
  LessonHeader(title: 'Rodzaje warstw'),
      LessonParagraph(text: 'Warstwy zewnętrzne nie tylko utrzymują poszczególne żyły razem, ale stanowią dla nich dodatkową ochronę przed wieloma czynnikami zewnętrznymi.'),
      LessonParagraph(text: 'Wśród warstw zewnętrznych wyróżniamy:'),
      LessonList(
          bullets: true,
          strings: [
            'ekran',
            'powłokę',
            'pancerz',
            'odzież',
          ]),
      LessonHeader(title: 'Ekran'),
      LessonParagraph(text: 'Jest to specjalna, cienka warstwa mająca na celu *ochronę przed zakłóceniami*. Może ona być wykonana z:'),
      LessonList(
          bullets: true,
          strings: [
            'folii aluminiowej',
            'splecionych drucików miedzianych (cynowanych)',
            'polietylenu z dodatkiem grafitu',
          ]),
      ImageCaption(path: 'assets/images/cables/cable_shielded.png', ignoreDarkMode: true,),
      LessonParagraph(text: 'Ekran może chronić zarówno przed *zakłóceniami elektromagnetycznymi z zewnątrz*, jak i *stabilizować rozkład pola elektrycznego* w przewodach energetycznych'),
      LessonParagraph(text: 'W zależności od sytuacji, ekran podłącza się do *zacisku uziemiającego* z jednej lub z dwóch stron.'),
      LessonParagraph(text: 'O podstawach ekranowania możesz przeczytać w poradniku przygotowanym przez firmę Phoenix Contact:'),
      LessonButtonLink(label: 'Podstawy ekranowania', url: 'https://www.phoenixcontact.com/pl-pl/technologie/ekranowanie/podstawy-ekranowania'),
      LessonHeader(title: 'Powłoka'),
      LessonParagraph(text: 'Powłoka stanowi dodatkową ochronę żył przed uszkodzeniami mechanicznymi i wnikaniem do wnętrza wody. Wykonuje się ją z takich samych materiałów jak izolację żyły (patrz poprzednia lekcja).'),
      LessonParagraph(text: 'Najcześciej spotykanymi powłokami są *polwinit* (przewody instalacyjne układane na stałe) oraz *guma*, którą znajdziemy na przewodach przeznaczonych do pracy na zewnątrz i przy odbiornikach ruchomych.'),
      LessonParagraph(text: 'Jeśli warunki są trudne (np. wysoka temperatura, wilgotność) przewód może zostać wyposażony w specjalnie pogrubioną powłokę (nazywamy ją wtedy *oponą*) lub powłokę podwójną.'),
      ImageCaption(path: 'assets/images/cables/cable_double_insulation.png', ignoreDarkMode: true, caption: 'Przewód w podwójnej powłoce (źródło: speckable.pl)',),
      //Obrazek podwójnej powłoki
      LessonHeader(title: 'Pancerz'),
      LessonParagraph(text: 'Pancerz umieszcza się zwykle między dwiema warstwami powłoki. Wykonuje się go najczęściej z:'),
      LessonList(
          bullets: true,
          strings: [
            'taśmy stalowej',
            'drutu stalowego',
          ]),
      LessonParagraph(text: 'Pancerz ma za zadanie chronić przed uszkodzeniami mechanicznymi. Pokryty nim przewód nazywamy *przewodem zbrojonym* lub *opancerzonym*.'),
      ImageCaption(path: 'assets/images/cables/cable_armoured.png', caption: 'Przewód zbrojony (źródło: zexum.com)', ignoreDarkMode: true,),
      LessonHeader(title: 'Odzież'),
      LessonParagraph(text: 'Odzież to warstwa materiału włóknistego (np. bawełny). Pokryty nią przewód nazywamy *sznurem*.'),
LessonParagraph(text: 'Odzież zabezpiecza żyły przewodu przed *wysoką temperaturą*. W odróżnieniu od polwinitu i polietylenu, *nie topi się*. Jest też znacznie tańsza od specjalistycznych, silikonowych powłok odpornych na wysokie temperatury.'),
      LessonParagraph(text: 'Stąd sznury stały się bardzo popularnymi przewodami zasilającymi *sprzęty gospodarstwa domowego*, takie jak żelazka, kuchenki elektryczne, czy opiekacze'),
      ImageCaption(path: 'assets/images/cables/cable_iron_cord.png', ignoreDarkMode: true, caption: 'Sznur mieszkaniowy',),

    ]);
