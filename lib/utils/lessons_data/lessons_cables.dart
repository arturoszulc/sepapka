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
  ImageCaption(path: 'assets/images/cables/cable_construction2.png', caption: 'źródło: cablematic.com', ignoreDarkMode: true,),
  LessonList(
      numbers: true,
      strings: [
        'żyła - element przewodzący prąd (fachowo: część czynna),',
        'izolacja - powłoka otaczająca żyły. Chroni je przed zwarciem między sobą i korozją,',
        'warstwy zewnętrzne - dodatkowa powłoka, pancerz, ekran lub odzież, w zależności od potrzeb,',
      ]),
  LessonParagraph(text: 'Poszczególne elementy przewodu zostały dokładnie opisane w kolejnych lekcjach.'),

]);


const Lesson cableLesson2 = Lesson(
    id: 'PE-2',
    title: 'Żyła przewodu',
    description: 'O materiałach, przekrojach i właściwościach żył',
    content: [
      LessonHeader(title: 'Materiał żył'),
      LessonParagraph(text: 'Żyła przewodu jest *przewodnikiem*, czyli *materiałem o niskiej rezystywności* lub po prostu *metalem*.'),
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
      LessonParagraph(text: 'Wspomniana wada nie zmienia faktu, że przewód sektorowy będzie miał *mniejszą średnicę* od przewodu z żyłami okrągłymi, o tej samej obciążalności prądowej.'),
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
      LessonParagraph(text: 'U producentów przewodów znajdziemy szczegółowe *tabele* zawierające liczby i średnice drutów dla wszystkich dostępnych przekrojów żył i klas.'),
      LessonParagraph(text: 'Dla przykładu, żyła o przekroju 1,5 mm\u00b2 będzie posiadać:'),
      LessonList(
          customBullets: ['klasa 1', 'klasa 2', 'klasa 5', 'klasa 6'],
          strings: [
            '1 drut o średnicy 1,38 mm',
            '7 drutów o średnicy 0,52 mm każdy',
            '30 drutów o średnicy 0,25 mm każdy',
            '84 drutów o średnicy 0,15 mm każdy',
          ]),
      LessonHeader(title: 'Przekroje żył'),
      LessonParagraph(text: 'Najważniejszą cechą każdej żyły jest jej *pole przekroju poprzecznego*. Im jest ono wyższe, tym większy prąd jest w stanie wytrzymać żyła.'),
      LessonParagraph(text: 'Europejska norma *IEC 60228* obejmuje również ten aspekt i tak u producentów znajdziemy przewody o następujących przekrojach żył:'),
      LessonParagraph(text: '0,5; 0,75; 1; 1,5; 2,5; 4; 6; 10; 16; 25; 35; 50; 70; 95; 120; 150; 185; 240; 300; 400; 500; 630; 800; 1000 mm\u00b2'),
      LessonCard(
          isFunFact: true,
          text: 'Norma dopuszcza stosowanie innych przekrojów w przypadku specjalnych zastosowań.\nPrzykładem może być przekrój 0,34 mm\u00b2, popularny w technice pomiarowej i sprzęcie audio, czy przekrój 2000 mm\u00b2 stosowany w liniach wysokiego napięcia.'),
      LessonParagraph(text: 'Warto wiedzieć, że na rynku możemy spotkać również przewody opisane jako *AWG* (ang. American Wire Gauge). Jest to standard stosowany między innymi w USA oraz Wielkiej Brytanii.'),
      LessonParagraph(text: 'Niestety nie da się go w prosty sposób przeliczyć na nasz europejski szereg. To znaczy, że w standardzie AWG nie znajdziemy odpowiednika europejskiej żyły 2,5 mm\u00b2. Najbliżej będą w tym wypadku AWG13 (przekrój 2,62 mm\u00b2) lub AWG14 (przekrój 2,08 mm\u00b2).'),
      LessonParagraph(text: 'Stąd, chcąc dobrać zamiennik w szeregu AWG, musimy albo zagłębić się w *tabele obciążalności prądowej*, albo skorzystać z *gotowych tabel* przygotowanych przez producentów przewodów. Do jednej z nich prowadzi poniższy przycisk:'),
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
              'W teorii ochrony przeciwporażeniowej zaliczamy ją do środków *ochrony podstawowej* (czyli przed dotykiem bezpośrednim).'),
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
      LessonParagraph(text: 'Warstwy zewnętrzne nie tylko utrzymują poszczególne żyły razem, ale stanowią dla nich *dodatkową ochronę* przed wieloma czynnikami zewnętrznymi.'),
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
      LessonParagraph(text: 'Jest to opcjonalna cienka warstwa, mająca na celu *ochronę przed zakłóceniami*. Wykonuje się ją z:'),
      LessonList(
          bullets: true,
          strings: [
            'folii aluminiowej',
            'splecionych drucików miedzianych (cynowanych)',
            'polietylenu z dodatkiem grafitu',
          ]),
      ImageCaption(path: 'assets/images/cables/cable_shielded.png', ignoreDarkMode: true,),
      LessonParagraph(text: 'Ekran może chronić przed *zakłóceniami elektromagnetycznymi z zewnątrz*, jak i *stabilizować rozkład pola elektrycznego* w przewodach energetycznych.'),
LessonParagraph(text: 'Napotkamy go głównie w przewodach przeznaczonych do *komunikacji*, *sterowania*, a także *zasilania silników* poprzez przemienniki częstotliwości.'),
      LessonParagraph(text: 'W zależności od sytuacji, ekran podłącza się do *zacisku uziemiającego* z jednej lub z dwóch stron.'),
      LessonParagraph(text: 'O podstawach ekranowania możesz przeczytać w poradniku przygotowanym przez firmę Phoenix Contact:'),
      LessonButtonLink(label: 'Podstawy ekranowania', url: 'https://www.phoenixcontact.com/pl-pl/technologie/ekranowanie/podstawy-ekranowania'),
      LessonHeader(title: 'Powłoka'),
      LessonParagraph(text: 'Powłoka stanowi dodatkową ochronę żył przed uszkodzeniami mechanicznymi i wnikaniem do wnętrza wody. Wykonuje się ją z takich samych materiałów jak izolację żył (patrz poprzednia lekcja).'),
      LessonParagraph(text: 'Najcześciej spotykanymi powłokami są: *polwinit* (przewody instalacyjne układane na stałe) oraz *guma*, (przewody przeznaczone do pracy na zewnątrz i przy odbiornikach ruchomych).'),
      LessonParagraph(text: 'Jeśli warunki są trudne (np. wysoka temperatura, wilgotność) przewód może zostać wyposażony w specjalnie pogrubioną powłokę (nazywamy ją wtedy *oponą*) lub powłokę podwójną.'),
      ImageCaption(path: 'assets/images/cables/cable_double_insulation.png', ignoreDarkMode: true, caption: 'Przewód w podwójnej powłoce (źródło: speckable.pl)',),
      //Obrazek podwójnej powłoki
      LessonHeader(title: 'Pancerz'),
      LessonParagraph(text: 'Pancerz umieszcza się zwykle między dwiema warstwami powłoki. Wykonuje się go z:'),
      LessonList(
          bullets: true,
          strings: [
            'taśmy stalowej',
            'drutu stalowego',
          ]),
      LessonParagraph(text: 'Pancerz ma za zadanie chronić przed uszkodzeniami mechanicznymi. Pokryty nim przewód nazywamy przewodem *zbrojonym* lub *opancerzonym*.'),
      ImageCaption(path: 'assets/images/cables/cable_armoured.png', caption: 'Przewód zbrojony (źródło: zexum.com)', ignoreDarkMode: true,),
      LessonHeader(title: 'Odzież'),
      LessonParagraph(text: 'Odzież to warstwa materiału włóknistego (np. bawełny). Pokryty nią przewód nazywamy *sznurem*.'),
LessonParagraph(text: 'Odzież zabezpiecza żyły przewodu przed *wysoką temperaturą*. W odróżnieniu od polwinitu i polietylenu, odzież *nie topi się*, a do tego jest znacznie tańsza od specjalistycznych powłok silikonowych.'),
      LessonParagraph(text: 'Stąd sznury stały się bardzo popularnymi przewodami zasilającymi *sprzęty gospodarstwa domowego*, takie jak żelazka, kuchenki elektryczne, czy opiekacze.'),
      ImageCaption(path: 'assets/images/cables/cable_iron_cord.png', ignoreDarkMode: true, caption: 'Sznur mieszkaniowy',),

    ]);


const Lesson cableLesson5 = Lesson(
    id: 'PE-5',
    title: 'Rodzaje i oznaczenia przewodów',
    description: 'O dostępnych typach przewodów',
    content: [
      LessonHeader(title: 'Dostępne rodzaje przewodów'),
  LessonParagraph(text: 'Wchodząc na stronę dowolnego producenta przewodów (Bitner, Lapp, Helukabel, Eltrim, Elpar itp.), znajdziemy *całą gamę przewodów* jedno- i wielożyłowych do różnych zastosowań.'),
  LessonParagraph(text: 'Elektrycy wykonujący instalacje domowe i przemysłowe, będą w swojej pracy wykorzystywać głównie:'),
  LessonList(
      bullets: true,
      strings: [
        'przewody instalacyjne (np. YDYżo, YDYp)',
        'przewody do odbiorników ruchomych (np. OWY, OMY, SM)',
        'kable (np. YAKY, YKY)',
        'przewody do przyłączy napowietrznych (AsXS)',
        'przewody komputerowe, alarmowe i telefoniczne (np. UTP, TDY)',
        'przewody antenowe, koncentryczne (np. YWDXpek)',
        'światłowody',
      ]),
  LessonParagraph(text: 'Z kolei automatycy i pracownicy utrzymania ruchu mogą napotkać dodatkowo:'),
  LessonList(
      bullets: true,
      strings: [
        'przewody sterownicze',
        'przewody specjalne (do stref zagrożonych wybuchem, higieniczne, wysokotemperaturowe itp.)',
        'przewody do serwonapędów',
        'przewody kompensacyjne',
      ]),
  LessonParagraph(text: 'Poszukując przewodu do konkretnego zastosowania, najlepiej przejrzeć ofertę dowolnego producenta lub skontaktować się z przedstawicielem handlowym.'),
  LessonHeader(title: 'Sposoby oznaczania przewodów'),
  LessonParagraph(text: 'W Polsce posługujemy się dwoma systemami oznaczeń:'),
  LessonList(
      bullets: true,
      strings: [
        'polskim (norma PN-E 90411:1993)',
        'europejskim (norma PN-HD 361 S3:2002)'
      ]),

  LessonHeader(title: 'System polski'),
  LessonParagraph(text: 'Norma definiująca polski system oznaczania przewodów została *wycofana* w 2002 roku.'),
  LessonParagraph(text: 'Mimo to, wielu elektryków i producentów do dziś się nim posługuje.'),
  LessonParagraph(text: 'Zgodnie z jego założeniami, każdy przewód musi być oznaczony:'),
  LessonList(
      bullets: true,
      strings: [
        'symbolem literowym (np. YDY)',
        'liczbą oraz przekrojem żył (np. 3x2,5)',
        'napięciem znamionowym (np. 300/500 V)'
      ]),
  LessonHeader(title: 'System polski - symbol literowy'),
  LessonParagraph(text: 'Symbol literowy koduje *budowę przewodu* (materiał żyły, izolacji oraz powłoki, występowanie ekranu, kształt przewodu itp.) oraz jego *cechy szczególne i przeznaczenie* (sterowniczy, spawalniczy, samonośny, niepalny itd.)'),
  LessonParagraph(text: 'Wszystkie symbole wraz z przykładami znajdziesz w tabeli poniżej:'),
      LessonButton(icon: Icons.table_chart_outlined, label: 'Symbole przewodów', screen: MyScreen.table_wire_symbols),
      LessonParagraph(text: 'Problemem polskiej symboliki jest fakt, że poszczególne znaki symbolu literowego *nie mają swojego stałego miejsca*, co pokazują dwa poniższe przykłady.'),
      LessonCard(
          isExample: true,
          text: 'W przewodzie AsXS, oznaczenie dodatkowe ,,s" (przewód samonośny) występuje *na drugim miejscu*.\n\n'
              'Z kolei inne oznaczenia dodatkowe, jak na przykład ,,p" (przewód o płaskiej budowie), występują *na końcu* symbolu, np. YDYp.'),
      LessonCard(
          isExample: true,
          text: 'Polwinit (PVC) oznaca się literą Y. Jeśli zarówno powłoka przewodu jak i izolacja żył wykonana jest z polwinitu, wówczas, litera Y występuje dwukrotnie (np. YDY).\n\n'
              'Inaczej jest z gumą. Jeśli izolacja żył przewodu oponowego warsztatowego (symbol OW) jest z polwinitu (symbol Y), to otrzymujemy symbol OWY. Jeśli jednak izolacja jest z gumy, to jej symbolu na końcu już nie podajemy i zostaje po prostu OW.'),
      LessonParagraph(text: 'Wspomniane mieszanie i pomijane pewnych oznaczeń może sprawiać początkującym elektrykom trudności w zdekodowaniu niektórych rzadziej spotykanych przewodów. Problem ten rozwiązał system europejski, o którym opowiem nieco później.'),

      LessonHeader(title: 'System polski - liczba i przekrój żył'),
      LessonParagraph(text: 'Tutaj system jest dość jednoznaczy i zapis wygląda następująco: *liczba żył x przekrój żył*.'),
LessonParagraph(text: 'W przypadku przewodów z żyłami *grupowowanymi* (np. skrętek) podajemy *liczba grup x liczba żył w grupie x przekrój żył*. Poniżej przykłady:'),
      LessonList(
          customBullets: ['3x1,5', '4x16', '1x0,5', '4x2x0,5', '16x3x0,5'],
          strings: [
        '3 żyły o przekroju 1,5 mm\u00b2 każda',
        '4 żyły o przekroju 16 mm\u00b2 każda',
        '1 żyła o przekroju 0,5 mm\u00b2',
        '4 pary żył o przekroju 0,5 mm\u00b2 każda',
        '16 trójek żył o przekrojach 0,5 mm\u00b2 każda',
      ]),
      LessonParagraph(text: 'W przypadku *przewodów jednożyłowych* (jak *1x0,5*) pisanie jedynki z przodu nie jest konieczne i wystarczy samo *0,5*. Mimo to producenci często pozostawiają zapis *1x0,5*, zapewne dla utrzymania konwencji.'),
      LessonHeader(title: 'System polski - napięcie znamionowe'),
      LessonParagraph(text: '*Napięcie znamionowe* to takie, na które dany przewód był projektowany.'),
      LessonParagraph(text: 'Dla *przewodów wielożyłowych* są to zawsze *dwie wartości* np. 300/500 V.'),
      LessonParagraph(text: 'Pierwsza oznacza *napięcie między żyła, a ziemią (lub ekranem)*. Druga oznacza *napięcie między żyłami*.'),
      LessonParagraph(text: 'Dla *przewodów jednożyłowych* z oczywistych względów wystarczy *jedna wartość*, np. DY 0,5 750V.'),
      LessonParagraph(text: 'U producentów znajdziemy przewody o następujących napięciach znamionowych:'),
      LessonList(
          bullets: true,
          strings: [
            '300/300 V',
            '300/500 V',
            '450/750 V',
            '600/1000 V',
            '1000/1000 V',
          ]),
      LessonParagraph(text: 'W typowych *instalacjach domowych* wystarcząjące będą przewody *300/300 V* (odbiorniki jednofazowe) i *300/500 V* (odbiorniki trójfazowe). Jednak przewody wyższej jakości i trwałości są zwykle produkowane na napięcia *450/750 V* (i wyższe).'),
      LessonParagraph(text: 'Zdarza się, że dla przewodów wielożyłowych producenci podają tylko tę wyższą wartość napięcia (np. YDYpżo 3x1,5 750 V). '
          'Wówczas to elektryk musi domyślić się, że tą niższą wartością jest 450 V.'),


      LessonHeader(title: 'System europejski'),
      LessonCard(
      isExample: true,
      text: 'Przewód o symbolu YDYp wyposażony jest w '),
  //YLgY-S(p)
  //Przewód samochodowy (S) na napięcie zanamionowe 24 V o żyłach z drutów miedzianych (Lg) w izolacji polwinitowej (Y), powłoce polwinitowej (Y), prostokątny (p).
  
]);



const Lesson cableLesson6 = Lesson(
    id: 'PE-6',
    title: 'Barwy przewodów',
    description: 'O kolorach i ich znaczeniu',
    content: [
      LessonHeader(title: 'Informacje ogólne'),
      LessonParagraph(text: 'Aby uniknąć pomyłek w stylu podłączenia przewodu fazowego do zacisku uziemienia, przewody oznacza się *barwami*.'),
      LessonParagraph(text: 'Listę wszystkich dostępnych barw i ich skróconych kodów znajdziesz w poniższej tabeli:'),
      LessonButton(icon: Icons.table_chart_outlined, label: 'Tabela barw przewodów', screen: MyScreen.table_wire_colors),
      LessonParagraph(text: 'Przewody powinny być oznaczone barwą na całej długości (barwna izolacja).'),
      LessonParagraph(text: 'Jeśli nie jest to możliwe, dopuszcza się oznaczenia *barwnymi znacznikami* tylko w widocznych i dostępnych miejscach lub ostatecznie na obu końcach przewodu'),
      LessonHeader(title: 'Barwa żółto-zielona'),
      LessonParagraph(text: 'Najważniejszą barwą dla każdego elektryka jest barwa *żółto-zielona*'),
      LessonParagraph(text:'Żyłę pokrytą taką barwą możemy wykorzystywać tylko i wyłacznie w roli *przewódu ochronnego PE*. Jeśli przewody *uziemiający (PEL)* i *wyrównawczy (FB)* są wykorzystywanie w ochronie przeciwporażeniowej, wówczas stają się niejako przedłużeniem przewodu ochronnego i one również powinny mieć barwę żółto-zieloną.'),
      LessonCard(
          isImportant: true,
          text: 'Aby zminimalizować ryzyko pomyłki, w przewodzie wielożyłowym posiadającym żyłę żółto-zieloną nie mogą znajdować się inne żyły o barwie żółtej lub zielonej'),
      LessonParagraph(text: 'Przewody ochronne nieposiadające izolacji (np. szynoprzewody) powinny być owinięte naprzemienne żółtymi i zielonymi paskami. Paski te powinny mieć szerokość 15 \u00F7 100 mm i przylegać do siebie'),
      LessonCard(
          isFunFact: true,
          text: 'W USA i Kanadzie przewód ochronny oznacza się barwą zieloną'),

      LessonHeader(title: 'Barwa jasnoniebieska'),
      LessonParagraph(text: 'Drugą najważniejszą barwą dla każdego elektryka jest barwa *jasnoniebieska*'),
      LessonParagraph(text: 'Barwa ta jest zarezerwowana dla *przewodu neutralnego N* i jego odpowiednika w obwodach prądu stałęgo, czyli *przewodu środkowego M*'),
      LessonParagraph(text: 'Jeżeli w danym obwodzie nie ma przewodu neutralnego ani środkowego (np. w obwodach sterowania), dopuszcza się wykorzystanie barwy jasnoniebieskiej w innym celu'),
      LessonParagraph(text: 'Szynoprzewody pozbawione izolacji być oznaczone jasnoniebieskimi paskami o szerokości 15 \u00F7 100 mm, rozmieszczonymi w równych, niewielkich odstępach.'),
      LessonCard(
          isFunFact: true,
          text: 'W USA i Kanadzie przewód neutralny i środkowy oznacza się barwą białą'),

      LessonHeader(title: 'Przewód PEN'),
      LessonParagraph(text: 'Przewód ochronno-neutralny PEN (spotykany w sieciach typu TN-C) jest jedynym przewodem, na którym znajdziemy aż *trzy barwy*: żółtą, zieloną i jasnoniebieską'),
      LessonParagraph(text: 'Norma *PN-HD 60364* mówi, że przewód ten może być oznaczony dwojako:'),
      LessonList(
          bullets: true,
          strings: [
            'barwą żółto-zieloną na całej długości i jasnoniebieskimi znacznikami na obu końcach',
            'barwą jasnoniebieską na całej długości i żółto-zielonymi znacznikami na obu końcach',
          ]),

      LessonHeader(title: 'Barwy przewodów fazowych'),
      LessonParagraph(text: 'Dla jak najlepszego odróżnienia przewodów fazowych od przewodów PE i N, norma *PN-HD 60364* zaleca następujące barwy:'),
      LessonList(
          customBullets: ['L1','L2','L3'],
          strings: [
            'brązową',
            'czarną',
            'szarą',
          ]),
      LessonParagraph(text: 'Warto zauważyć, że barwy te są uszeregowane *alfabetycznie* (b-c-s), co pomaga zapamiętać ich kolejność.'),
      LessonParagraph(text: 'W przypadku *obwodów prądu stałego*, jedynymi znormalizowanymi kolorami jest oczywiście barwa żółto-zielona (przewód ochronny PE) oraz jasnoniebieska (przewód środkowy M).'),
      LessonParagraph(text: 'Kolory biegunów dodatniego (L+) i ujemnego (L-) nie są znormalizowane.'),
      LessonHeader(title: 'Inne barwy'),
      LessonParagraph(text: 'Pozostałę barwy mogą być stosowane bez specjalnych ograniczeń, z tym że w przewodzie wielożyłowym o kolorowych żyłach, każda z nich powinna mieć niepowtarzalną barwę.'),
      LessonParagraph(text: 'W przewodach o kilkudziesięciu żyłach niepowtarzalność uzyskuje się dzięi dwukolorwym wzorom (ale nie żółto-zielonym)'),
      LessonParagraph(text: 'W przewodach parowanych dopuszcza się powtarzanie barw, jeśli przewód taki jest sparowany (np. przez skręcenie) z innym przewodem o niepowtarzalnej barwie'),
    ]);
