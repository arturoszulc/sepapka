import 'package:flutter/material.dart';

class TableWireColors {
  final List<String> headers = ['Nazwa (PL)', 'Nazwa (ENG)', 'Kod', 'Kolor'];
  final List<Przewod> rows = [
    const Przewod('czarna', 'black', 'BK', Colors.black),
    const Przewod('brązowa', 'brown', 'BN', Colors.brown),
    const Przewod('czerwona', 'red', 'RD', Colors.red),
    const Przewod('pomarańczowa', 'orange', 'OG', Colors.orange),
    const Przewod('żółta', 'yellow', 'YE', Colors.yellow),
    const Przewod('zielona', 'green', 'GN', Colors.green),
    const Przewod('niebieska\n(jasnoniebieska)', 'blue\n(lightblue)', 'BU', Colors.blue),
    const Przewod('fioletowa', 'violet', 'VT', Colors.purple),
    const Przewod('szara', 'grey', 'GY', Colors.grey),
    const Przewod('biała', 'white', 'WH', Colors.white),
    const Przewod('różowa', 'pink', 'PK', Colors.pink),
    Przewod('złota', 'gold', 'GD', Colors.yellowAccent.shade700),
    const Przewod('turkusowa', 'turquoise', 'TQ', Colors.teal),
    Przewod('srebrna', 'silver', 'SR', Colors.grey.shade300),
    Przewod('żółto-zielona', 'green and\nyellow', 'GNYE', Colors.lightGreenAccent),
  ];
}

class Przewod {
  final String namePL;
  final String nameENG;
  final String colorCode;
  final Color color;

  const Przewod(this.namePL, this.nameENG, this.colorCode, this.color);
}
