
import '../../models/academy/unit_lesson_model.dart';
import '../../utils/custom_widgets/layout/layout_custom_widgets.dart';

const Lesson gridLesson1 = Lesson(
  id: 'SNP-1',
  title: 'Podstawy sieci',
  description: 'O podstawowych typach sieci i znaczeniu poszczególnych symboli.',
  content: [
    LessonHeader(title: 'Informacje ogólne'),
    LessonParagraph(text: 'Sieci prądu przemiennego dzielimy na *jednofazowe* i *trójfazowe*.'),
    LessonParagraph(
        text:
            'Oprócz przewodów fazowych (L), sieć może posiadać przewody: *neutralny (N)*, *ochronny (PE)* lub *ochronno-neutralny (PEN)*. '
            'W praktyce stosowane są sieci:'),
    LessonList(bullets: true, strings: [
      'jednofazowe dwuprzewodowe (L+N),',
      'jednofazowe dwuprzewodowe (L+PEN),',
      'jednofazowe trójprzewodowe (L+N+PE),',
      'trójfazowe trójprzewodowe (3\u00d7L),',
      'trójfazowe czteroprzewodowe (3\u00d7L+N),',
      'trójfazowe czteroprzewodowe (3\u00d7L+PE),',
      'trójfazowe czteroprzewodowe (3\u00d7L+PEN),',
      'trójfazowe pięcioprzewodowe (3\u00d7L+N+PE).',
    ]),
    LessonParagraph(
        text:
            'To jakie przewody posiada sieć zależy od *sposobu jej uziemienia* oraz rodzaju przewodu realizującego *funkcję ochronną*. O tym wszystkim mówi nam *typ sieci*.'),
    LessonHeader(title: 'Podstawowe typy sieci'),
    LessonParagraph(
        text:
            'Ze względu na sposób połączenia sieci z ziemią, wyróżniamy sieci typu *TN*, *TT* oraz *IT*. '
            'Jeśli chodzi o przewód ochronny, to takowy posiada tylko sieć *TN*. Stąd, ze względu na jego rodzaj, wyróżniamy podtypy *TN-S*, *TN-C* i *TN-C-S*.'),
    LessonCard(
        isImportant: true,
        text:
            'Sieci typu *TT* oraz *IT* nie posiadają ,,fabrycznego" przewodu realizującego funkcję ochronną. '
            'W ich przypadku o taki przewód musimy zadbać sami, po stronie instalacji.'),
    LessonHeader(title: 'Pochodzenie symboli'),
    LessonParagraph(
        text: 'Symbole opisujące typ sieci wywodzą się z następujących francuskich określeń:'),
    LessonList(strings: [
      'T – terre – ziemia,',
      'I – isolation – izolować,',
      'N – neutre – neutralny,',
      'S – separe  - oddzielny,',
      'C – combine – połączony.',
    ]),
    LessonHeader(title: 'Znaczenie symboli'),
    LessonParagraph(
        text:
            'Pierwsza litera typu sieci (np. w TN-S jest to litera T) opisuje sposób *połączenia sieci z ziemią*:'),
    LessonList(strings: [
      'T - bezpośrednie (metaliczne) połączenie,',
      'I - całkowita izolacja lub połączenie przez dużą impedancję.',
    ]),
    LessonParagraph(
        text:
            'Druga litera opisuje sposób połączenia z ziemią *części przewodzących dostępnych*, czyli wszystkich metalowych elementów, które w razie awarii mogą znaleźć się pod napięciem:'),
    LessonList(strings: [
      'T - bezpośrednie (metaliczne) połączenie,',
      'N - połączenie przez przewód ochronny wyprowadzony z uziemionego punktu sieci (najczęściej punktu neutralnego).',
    ]),
    LessonParagraph(
        text:
            'W przypadku sieci *TN*, po myślniku możemy znaleźć jeszcze dwa symbole, które określają typ *przewodu ochronnego*:'),
    LessonList(strings: [
      'C - przewód ochronno-neutralny (PEN),',
      'S - przewód ochronny (PE),',
      'C-S - część sieci jak w układzie C, pozostała część jak w S.',
    ]),
    LessonCard(
        isExample: true,
        text:
            'Sieć typu TN-C jest bezpośednio uziemiona (T), a wszystkie podłączone do niej części przewodzące dostępne są uziemione przez punkt neutralny (N). Posiada ona również przewód pełniący funkcję ochronną (C), w tym przypadku przewód ochronno-neutralny PEN.'),
  ],
);



const Lesson gridLesson2 = Lesson(
    id: 'SNP-2',
    title: 'Sieci TN, TT oraz IT',
    description: 'O budowie i zastosowanie podstawowych sieci.',
    content: [
  LessonHeader(title: 'Sieć TN - informacje ogólne'),
  LessonParagraph(text: 'Sieci typu TN znajdują zastosowanie jako:'),
  LessonList(bullets: true, strings: [
    'sieci rozdzielcze zasilające budynki mieszkalne i użyteczności publicznej,',
    'instalacje elektryczne w budynkach i obiektach przemysłowych.',
  ]),
  LessonParagraph(
      text: 'Sieć typu TN jest siecią *uziemioną* przynajmniej w jednym punkcie. '
          'Z tego punktu wyprowadzony jest *przewód ochronny*, do którego podłączamy wszystkie *części przewodzące dostępne*.'),
  LessonParagraph(text: 'Ze względu na typ *przewodu ochronnego*, wyróżniamy sieci:'),
  LessonList(bullets: true, strings: [
    'TN-C - funkcję ochronną pełni przewód neutralny (PEN),',
    'TN-S - funkcję ochronną pełni niezależny przewód (PE),',
    'TN-C-S - w części sieci znajduje się przewód PEN, po czym następuję jego podział na dwa przewody (PE oraz N).',
  ]),

  LessonHeader(title: 'Sieć TN-C - budowa'),
  LessonParagraph(text: 'Sieć typu TN-C posiada następujące przewody:'),
  LessonList(bullets: true, strings: [
    'fazowy (L),',
    'ochronno-neutralny (PEN).',
  ]),
  LessonParagraph(text:'W wersji jednofazowej jest to sieć *dwuprzewodowa*, zaś w trójfazowej *czteroprzewodowa*:'),
  ImageCaption(path: 'assets/images/grid/grid_tnc_1ph.png'),
  ImageCaption(path: 'assets/images/grid/grid_tnc_3ph.png'),

  LessonHeader(title: 'Sieć TN-S - budowa'),
  LessonParagraph(text: 'Sieć typu TN-S posiada następujące przewody:'),
  LessonList(bullets: true, strings: [
    'fazowy (L),',
    'neutralny (N),',
    'ochronny (PE).',
  ]),
  LessonParagraph(text: 'W wersji jednofazowej jest to sieć *trójprzewodowa*, zaś w trójfazowej *pięcioprzewodowa*:'),
  ImageCaption(path: 'assets/images/grid/grid_tns_1ph.png'),
  ImageCaption(path: 'assets/images/grid/grid_tns_3ph.png'),

  LessonHeader(title: 'Sieć TN-C-S - budowa'),
  LessonParagraph(text: 'Sieć typu TN-C-S posiada następujące przewody:'),
  LessonList(bullets: true, strings: [
    'fazowy (L),',
    'ochronno-neutralny (PEN) (rozdzielony w pewnym momencie na PE i N).',
  ]),
  LessonParagraph(text: 'W wersji jednofazowej jest to sieć *dwuprzewodowa*, która w punkcie rozdziału zamienia się w *trójprzewodową*. Wersja trójfazowa zaś przechodzi z *czteroprzewodowej* w *pięcioprzewodową*.'),
  ImageCaption(path: 'assets/images/grid/grid_tncs_1ph.png'),
  ImageCaption(path: 'assets/images/grid/grid_tncs_3ph.png'),



  LessonHeader(title: 'Sieć TT - informacje ogólne'),
  LessonParagraph(text: 'Sieci typu TT znajdują zastosowanie jako:'),
  LessonList(bullets: true, strings: [
    'sieci rozdzielcze zasilające budynki mieszkalne i użyteczności publicznej,',
    'instalacje w budynkach i obiektach przemysłowych,',
    'instalacje w obiektach rolniczych i ogrodniczych.',
  ]),
  LessonParagraph(
      text: 'Sieć typu TT jest siecią *uziemioną* przynajmniej w jednym punkcie. '
          'Z powodu braku przewodu ochronnego *części przewodzące dostępne* muszą być *bezpośrednio uziemione*.'),

  LessonHeader(title: 'Sieć TT - budowa'),
  LessonParagraph(text: 'Sieć typu TT posiada następujące przewody:'),
  LessonList(bullets: true, strings: [
    'fazowy (L)',
    'neutralny (N)',
  ]),
  LessonParagraph(text:'W wersji jednofazowej jest to sieć *dwuprzewodowa*, zaś w trójfazowej *czteroprzewodowa*:'),
  ImageCaption(path: 'assets/images/grid/grid_tt_1ph.png'),
  ImageCaption(path: 'assets/images/grid/grid_tt_3ph.png'),


  LessonHeader(title: 'Sieć IT - informacje ogólne'),
  LessonParagraph(text: 'Sieć typu IT stosuje się wszędzie tam, gdzie:'),
  LessonList(bullets: true, strings: [
    'utrzymanie ciągłości zasilania jest kluczowe,',
    'występuje zagrożenie pożarowe lub wybuchowe.',
  ]),
  LessonParagraph(text: 'Stąd doskonale sprawdza się ona w roli:'),
  LessonList(bullets: true, strings: [
    'instalacji w obiektach medycznych i serwerowniach,',
    'instalacji w przemyśle górniczym i chemicznym,',
    'instalacji oświetlenia bezpieczeństwa.',
  ]),
  LessonParagraph(
      text: 'Sieć typu IT jest siecią *nieuziemioną* lub *uziemioną przez dużą impedancję*. '
          'Części przewodzące dostępne połączone z tą siecią muszą być *bezpośrednio uziemione*.'),

  LessonHeader(title: 'Sieć IT - budowa'),
  LessonParagraph(text: 'Sieć typu IT posiada następujące przewody:'),
  LessonList(bullets: true, strings: [
    'fazowy (L),',
    'neutralny (N).',
  ]),
  LessonParagraph(text:'W wersji jednofazowej jest to sieć *dwuprzewodowa*, zaś w trójfazowej *czteroprzewodowa*.'),
  ImageCaption(path: 'assets/images/grid/grid_it_1ph.png'),
  ImageCaption(path: 'assets/images/grid/grid_it_3ph.png'),
  LessonCard(
      isFunFact: true,
      text: 'Brak uziemienia sieci IT stanowi jej największą zaletę, ale też spore wyzwanie w przypadku obwodów trójfazowych z niesymetrycznymi odbiornikami. '
          'Stąd tam gdzie to możliwe zaleca się stosowanie odbiorników symetrycznych i całkowitą rezygnację z przewodu neutralnego.'),

]);



const Lesson gridLesson3 = Lesson(
    id: '3',
    title: 'Zakresy napięciowe instalacji elektrycznych',
    description: 'O standardach napięciowych w instalacjach prądu przemiennego i stałego',
    content: [
      LessonHeader(title: 'Niskie napięcie'),
      LessonParagraph(text: 'Górną granicą dla sieci i instalacji *niskiego napięcia* są wartości:'),
      LessonList(
          bullets: true,
          strings: [
            '1000 V dla prądu przemiennego,',
            '1500 V dla prądu stałego.',
          ]),
      LessonParagraph(text: 'W przypadku prądu przemiennego mówimy o napięciu *skutecznym, międzyfazowym* o maksymalnej częstotliwości równej 60 Hz.'),
      LessonParagraph(text: 'Z kolei w przypadku prądu stałego mówimy tu o napięciu *między biegunami* źródła.'),

      LessonHeader(title: 'Zakresy napięciowe'),
      LessonParagraph(text: 'Ze względu na różne metody realizacji ochrony przeciwporażeniowej, wyróżniamy dwa zakresy napięć:'),
      LessonParagraph(text: '*Zakres I* - jest to tak zwane *bardzo niskie napięcie*, które samo w sobie nie stanowi zagrożenia dla człowieka. Jeśli odpowiednio odseparujemy taką instalację od wpływu wyższych napięć, wówczas dodatkowe środki ochrony nie są konieczne.'),
      LessonParagraph(text: '*Zakres II* - w tym przypadku napięcia są na tyle wysokie, że konieczne jest stosowanie środków ochrony przeciwporażeniowej.'),

      LessonHeader(title: 'Zakres napięciowy I'),
      LessonParagraph(text: 'Maksymalną wartością napięcia przemiennego (skutecznego) dla *zakresu I* jest *50 V*. Wartości tej nie może przekroczyć ani napięcie fazowe, ani międzyfazowe, bez względu na typ sieci z jaką mamy do czynienia.'),
      LessonParagraph(text: 'Ta sama zasada dotyczy napięcia stałego, z tym że tutaj limit podniesiony jest do *120 V*.'),

      LessonHeader(title: 'Zakres napięciowy II'),
      LessonParagraph(text: 'Napięcie przemienne *zakresu II* nie może przekroczyć:'),
      LessonList(
          bullets: true,
          strings: [
            '600 V między fazą, a ziemią,',
            '1000 V między fazami.',
          ]),
      LessonParagraph(text: 'Jeśli sieć jest nieuziemiona (typ IT), wówczas dotyczy jej limit 1000 V między fazami.'),
      LessonParagraph(text: 'Napięcie stałe *zakresu II* nie może przekroczyć:'),
      LessonList(
          bullets: true,
          strings: [
            '900 V między biegunem, a ziemią,',
            '1500 V między biegunami.',
          ]),
      LessonParagraph(text: 'Jeśli sieć jest nieuziemiona (typ IT), wówczas dotyczy jej limit 1500 V między biegunami.'),
    ]);

const Lesson gridLesson4 = Lesson(
    id: '4',
    title: 'Napięcia znamionowe w Polsce',
    description: 'O napięciach znamionowych i preferowanych prądu stałego i przemiennego',
    content: []);




