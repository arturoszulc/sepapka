import '../../models/academy/unit_lesson_model.dart';
import '../custom_widgets/layout/bullet_list.dart';
import '../custom_widgets/layout/header.dart';
import '../custom_widgets/layout/image_caption.dart';
import '../custom_widgets/layout/paragraph.dart';

const Lesson cableLesson1 = Lesson(
  id: '1-1',
    title: 'Budowa przewodów elektrycznych',
    content: [
        CustomHeader(title: 'Informacje ogólne'),
        CustomParagraph(text: 'Sieci prądu przemiennego dzielimy na *jednofazowe* i *trójfazowe*.'),
        CustomParagraph(text: 'Oprócz przewodów fazowych, sieć może posiadać przewody: *neutralny*, *ochronny* lub *ochronno-neutralny*. Konfiguracja zależy od *typu sieci* z jakim mamy do czynienia.'),
        CustomHeader(title: 'Podstawowe typy sieci'),
        CustomParagraph(text: 'Obecnie stosowane typy sieci to *TN*, *IT* oraz *TT*. Sieci TN dzielą się dodatkowo na *TN-S*, *TN-C* i *TN-C-S*. Poszczególne litery odnoszą się do następujących francuskich określeń:'),
        CustomList(strings: [
          'T – terre – ziemia',
          'I – isolation – izolować',
          'N – neutre – neutralny',
          'S – separe  - oddzielny',
          'C – combine – połączony',
        ]),
        CustomParagraph(text: 'Znaczenie każdej z liter w kontekście budowy sieci przedstawiono poniżej.'),
        ImageCaption(path: 'assets/images/cables/przewod_ekranowany.png', caption: 'źródło: bitner.com', ignoreDarkMode: true,),
        CustomParagraph(text: 'Znaczenie każdej z liter w kontekście budowy sieci przedstawiono poniżej.'),

      ],
    );