import 'package:flutter/material.dart';

class TableWireColors {
  final List<String> headers = ['Nazwa (PL)', 'Nazwa (ENG)', 'Kod', 'Kolor'];
  final List<Wire> rows = [
    const Wire('czarna', 'black', 'BK', Colors.black),
    const Wire('brązowa', 'brown', 'BN', Colors.brown),
    const Wire('czerwona', 'red', 'RD', Colors.red),
    const Wire('pomarańczowa', 'orange', 'OG', Colors.orange),
    const Wire('żółta', 'yellow', 'YE', Colors.yellow),
    const Wire('zielona', 'green', 'GN', Colors.green),
    const Wire('niebieska\n(jasnoniebieska)', 'blue\n(lightblue)', 'BU', Colors.blue),
    const Wire('fioletowa', 'violet', 'VT', Colors.purple),
    const Wire('szara', 'grey', 'GY', Colors.grey),
    const Wire('biała', 'white', 'WH', Colors.white),
    const Wire('różowa', 'pink', 'PK', Colors.pink),
    Wire('złota', 'gold', 'GD', Colors.yellowAccent.shade700),
    const Wire('turkusowa', 'turquoise', 'TQ', Colors.teal),
    Wire('srebrna', 'silver', 'SR', Colors.grey.shade300),
    const Wire('żółto-zielona', 'green and\nyellow', 'GNYE', Colors.greenAccent),
  ];
}

class Wire {
  final String namePL;
  final String nameENG;
  final String colorCode;
  final Color color;

  const Wire(this.namePL, this.nameENG, this.colorCode, this.color);
}
