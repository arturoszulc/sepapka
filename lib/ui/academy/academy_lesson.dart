import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sepapka/utils/custom_widgets/layout/bullet_list.dart';
import 'package:sepapka/utils/custom_widgets/layout/header.dart';

import '../../utils/consts/my_screens.dart';

class AcademyLesson extends StatelessWidget {
  const AcademyLesson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            context.pushNamed(MyScreen.academyIndex.name);
          }, icon: const Icon(Icons.menu_book)),
        ],
      ),
      body: Center(
        child: Column(
          children: const [
            CustomHeader(title: 'Informacje ogólne'),
            Text('Sieci prądu przemiennego dzielimy na jednofazowe i trójfazowe. Oprócz przewodów fazowych sieć może posiadać przewód neutralny, ochronny lub ochronno-neutralny w różnych konfiguracjach. O tym jakie przewody posiada sieć mówi nam typ sieci.'),
            CustomHeader(title: 'Podstawowe typy sieci'),
            Text('Sieci zarówno jedno- jak i trójfazowe dzielimy na sieci typu TN, IT oraz TT. Oprócz tego sieci TN dzielą się na TN-S, TN-C i TN-C-S. Poszczególne litery odnoszą się do następujących francuskich określeń:'),
            BulletList(strings: [
              'T – terre – ziemia',
              'I – isolation – izolować',
              'N – neutre – neutralny',
              'S – separe  - oddzielny',
              'C – combine – połączony',
            ]),
            Text('Każda z liter ma konkretne znaczenie jeśli chodzi o budowę sieci, co pokazuje obrazek poniżej')
          ],
        ),
      ),
    );
  }
}



