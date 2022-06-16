import 'package:flutter/material.dart';


const silverColor = Color(0xffC0C0C0);
const goldColor = Color(0xffFFD700);

const List<String> tableWireColorDataHeaders = ['Nazwa (PL)', 'Nazwa (ENG)', 'Kod', 'Kolor'];
const List<Wire> tableWireColorDataRows = [
  Wire('czarna', 'black', 'BK', Colors.black),
  Wire('brązowa', 'brown', 'BN', Colors.brown),
  Wire('czerwona', 'red', 'RD', Colors.red),
  Wire('pomarańczowa', 'orange', 'OG', Colors.orange),
  Wire('żółta', 'yellow', 'YE', Colors.yellow),
  Wire('zielona', 'green', 'GN', Colors.green),
  Wire('niebieska\n(jasnoniebieska)', 'blue\n(lightblue)', 'BU', Colors.blue),
  Wire('fioletowa', 'violet', 'VT', Colors.purple),
  Wire('szara', 'grey', 'GY', Colors.grey),
  Wire('biała', 'white', 'WH', Colors.white),
  Wire('różowa', 'pink', 'PK', Colors.pink),
  Wire('złota', 'gold', 'GD', goldColor),
  Wire('turkusowa', 'turquoise', 'TQ', Colors.teal),
  Wire('srebrna', 'silver', 'SR', silverColor),
  Wire('żółto-zielona', 'green and\nyellow', 'GNYE', Colors.greenAccent),
];

class Wire {
  final String namePL;
  final String nameENG;
  final String colorCode;
  final Color color;

  const Wire(this.namePL, this.nameENG, this.colorCode, this.color);
}
