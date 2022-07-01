

const List<String> tableWireDiameterHeaders = ['Przekrój [mm\u00b2]', 'Średnica maks. [mm]', 'Odpowiednik AWG'];

const List<WireDiameter> tableWireDiameterRows = [
  WireDiameter('0,05', '-', '30'),
  WireDiameter('0,08', '-', '28'),
  WireDiameter('0,14', '-', '26'),
  WireDiameter('0,25', '-', '24'),
  WireDiameter('0,34', '-', '22'),
  WireDiameter('0,38', '-', '21'),
  WireDiameter('0,50', '1,1', '20'),
  WireDiameter('0,75', '1,2', '18'),
  WireDiameter('1,0', '1,4', '17'),
  WireDiameter('1,5', '1,7', '16'),
  WireDiameter('2,5', '2,2', '14'),
  WireDiameter('4', '2,7', '12'),
  WireDiameter('6', '3,3', '10'),
  WireDiameter('10', '4,2', '8'),
  WireDiameter('16', '5,3', '6'),
  WireDiameter('25', '6,6', '4'),
  WireDiameter('35', '7,9', '2'),
  WireDiameter('50', '9,1', '1'),
  WireDiameter('70', '11,0', '2/0'),
  WireDiameter('95', '12,9', '3/0'),
  WireDiameter('120', '14,5', '4/0'),
  WireDiameter('150', '16,2', '300 kcmil'),
  WireDiameter('185', '18,0', '250 kcmil'),
  WireDiameter('240', '20,6', '500 kcmil'),
  WireDiameter('300', '23,1', '600 kcmil'),
  WireDiameter('400', '26,1', '750 kcmil'),
  WireDiameter('500', '29,2', '1000 kcmil'),
  WireDiameter('630', '33,2', '1000 kcmil'),
  WireDiameter('800', '37,6', '1000 kcmil'),
  WireDiameter('1000', '42,2', '1000 kcmil'),
];



class WireDiameter {
  final String mm2;
  final String diameter;
  final String awg;

  const WireDiameter(this.mm2, this.diameter, this.awg);
}