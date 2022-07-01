import 'package:flutter/material.dart';


const silverColor = Color(0xffC0C0C0);
const goldColor = Color(0xffFFD700);

const List<String> tableWireColorDataHeaders = ['Nazwa (PL)', 'Nazwa (ENG)', 'Kod', 'Kolor'];
const List<WireColor> tableWireColorDataRows = [
  WireColor('czarna', 'black', 'BK', Colors.black),
  WireColor('brązowa', 'brown', 'BN', Colors.brown),
  WireColor('czerwona', 'red', 'RD', Colors.red),
  WireColor('pomarańczowa', 'orange', 'OG', Colors.orange),
  WireColor('żółta', 'yellow', 'YE', Colors.yellow),
  WireColor('zielona', 'green', 'GN', Colors.green),
  WireColor('niebieska\n(jasnoniebieska)', 'blue\n(lightblue)', 'BU', Colors.blue),
  WireColor('fioletowa', 'violet', 'VT', Colors.purple),
  WireColor('szara', 'grey', 'GY', Colors.grey),
  WireColor('biała', 'white', 'WH', Colors.white),
  WireColor('różowa', 'pink', 'PK', Colors.pink),
  WireColor('złota', 'gold', 'GD', goldColor),
  WireColor('turkusowa', 'turquoise', 'TQ', Colors.teal),
  WireColor('srebrna', 'silver', 'SR', silverColor),
  WireColor('żółto-zielona', 'green and\nyellow', 'GNYE', Colors.greenAccent),
];

class WireColor {
  final String namePL;
  final String nameENG;
  final String colorCode;
  final Color color;

  const WireColor(this.namePL, this.nameENG, this.colorCode, this.color);
}
