import '../../models/academy/unit_lesson_model.dart';
import '../../utils/custom_widgets/layout/layout_custom_widgets.dart';


const Lesson cableLesson1 = Lesson(
    id: '1',
    title: 'Jak zbudowane są przewody?', content: [
  CustomHeader(title: 'Informacje ogólne'),
  CustomParagraph(text: 'Przewody elektryczne służą do *przesyłania energii elektrycznej*. Stąd ważne, by były one:'
      'by:'),
  CustomList(
    bullets: true,
    strings: [
      'oszczędne - czyli nie nagrzewały się i nie marnowały w ten sposób energii elektrycznej,',
      'bezpieczne - nie chcemy aby parzenia kawy i suszenie włosów suszarką kojarzyło nam się wiecznie ze strachem, ',
      'wytrzymałe - wyobraź sobie, że co roku musiałbyś pruć ściany i układać nową instalację. No właśnie.',
    ],
  ),
  CustomHeader(title: 'Budowa'),
  CustomParagraph(text: 'Aby spełnić powyższe założenia, przewody elektryczne składają się zwykle z:'),
  ImageCaption(path: 'assets/images/cables/przewod_ekranowany.png', caption: 'źródło: bitner.com', ignoreDarkMode: true,),
  CustomList(
      numbers: true,
      strings: [
        'żyła - element przewodzący prąd (fachowo: część czynna)',
        'izolacja - powłoka otaczająca żyły. Chroni je przed zwarciem między sobą i korozją',
        'ekran - element chroniący przed zakłóceniami elektromagnetycznymi',
        'warstwy ochronne - dodatkowa powłoka, pancerz lub odzież, w zależności od potrzeb',
      ]),
  CustomParagraph(text: 'Poszczególne elementy przewodu zostały dokładnie opisane w kolejnych lekcja.'),

]);


const Lesson cableLesson2 = Lesson(
    id: '2',
    title: 'Żyła - serce każdego przewodu',
    content: [
      CustomHeader(title: 'Budowa żyły'),
      CustomParagraph(text: 'Żyła przewodu jest *przewodnikiem*. Inaczej mówiąc *materiałem o niskiej rezystywności*. A mówiąc najprościej: *metalem*.'),
      CustomParagraph(text: 'Najlepiej przewodzącym metalem jest *srebro*, ale ze względu na jego wysoką cenę żyły wykonuje się zwykle z *miedzi* i *aluminium*.'),
      CustomFunFact(text: 'Drogie przewodniki, takie jak srebro i złoto, mają wiele pożądanych zalet. '
          'Stąd żyły miedziane niekiedy posrebrza się lub pozłaca, by zmniejszyć ich rezystancję, osiągnąć odporność na wyższą temperaturę lub odporność na zakłócenia.'),

    ]);