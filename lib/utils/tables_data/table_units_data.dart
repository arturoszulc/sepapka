
final List<UnitGroup> unitGroups = [
  UnitGroup(name: 'Długość, powierzchnia, objętość, kąt', tiles: const [
    UnitTile(name: 'długość', unit: 'metr', symbol: 'm'),
    UnitTile(name: 'powierzchnia', unit: 'metr kwadratowy', symbol: 'm\u00b2'),
    UnitTile(name: 'objętość', unit: 'metr sześcienny', symbol: 'm\u00b3'),
    UnitTile(name: 'kąt płaski', unit: 'radian', symbol: 'rad'),
    UnitTile(name: 'kąt bryłowy', unit: 'steradian', symbol: 'sr'),
  ]),
  UnitGroup(name: 'Czas, częstotliwość, prędkość, przyspieszenie', tiles: const [
    UnitTile(name: 'czas', unit: 'sekunda', symbol: 's'),
    UnitTile(name: 'częstotliwość', unit: 'herc', symbol: 'Hz'),
    UnitTile(name: 'prędkość obrotowa', unit: 'na sekundę', symbol: '1/s'),
    UnitTile(name: 'pulsacja', unit: 'na sekundę', symbol: '1/s'),
    UnitTile(name: 'prędkość', unit: 'metr na sekundę', symbol: 'm/s'),
    UnitTile(name: 'prędkość kątowa', unit: 'radian na sekundę', symbol: 'rad/s'),
    UnitTile(name: 'przyspieszenie', unit: '-', symbol: 'm/s\u00b2'),
  ]),

];


class UnitGroup {
  final String name;
  bool isExpanded;
  final List<UnitTile> tiles;

  UnitGroup({required this.name, this.isExpanded = false, required this.tiles});
}

class UnitTile {
  final String name;
  final String unit;
  final String symbol;

  const UnitTile({required this.name, required this.unit, required this.symbol});
}