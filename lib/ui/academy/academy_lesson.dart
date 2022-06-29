import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/utils/custom_widgets/layout/bullet_list.dart';
import 'package:sepapka/utils/custom_widgets/layout/header.dart';
import 'package:sepapka/utils/custom_widgets/layout/image_caption.dart';
import 'package:sepapka/utils/custom_widgets/layout/paragraph.dart';

import '../../utils/consts/my_screens.dart';

class AcademyLesson extends StatelessWidget {
  const AcademyLesson({Key? key}) : super(key: key);

  static const TextStyle bold = TextStyle(
    fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lekcja'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            context.pushNamed(MyScreen.academyIndex.name);
          }, icon: const Icon(Icons.menu_book)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            CustomHeader(title: 'Informacje ogólne'),
            CustomParagraph(text: 'Sieci prądu przemiennego dzielimy na *jednofazowe* i *trójfazowe*.'),
            CustomParagraph(text: 'Oprócz przewodów fazowych, sieć może posiadać przewody: *neutralny*, *ochronny* lub *ochronno-neutralny*. Konfiguracja zależy od *typu sieci* z jakim mamy do czynienia.'),
            CustomHeader(title: 'Podstawowe typy sieci'),
            CustomParagraph(text: 'Obecnie stosowane typy sieci to *TN*, *IT* oraz *TT*. Sieci TN dzielą się dodatkowo na *TN-S*, *TN-C* i *TN-C-S*. Poszczególne litery odnoszą się do następujących francuskich określeń:'),
            BulletList(strings: [
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
        ),
      ),
    );
  }
}



