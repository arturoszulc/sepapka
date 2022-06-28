
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
    UnitTile(name: 'przyspieszenie', unit: '', symbol: 'm/s\u00b2'),
  ]),
  UnitGroup(name: 'Mechanika', tiles: const [
    UnitTile(name: 'masa', unit: 'kilogram', symbol: 'kg'),
    UnitTile(name: 'gęstość masy', unit: '', symbol: 'kg/m\u00b3'),
    UnitTile(name: 'moment bezwładności', unit: '', symbol: 'kg \u00b7 m'),
    UnitTile(name: 'siła', unit: 'niuton', symbol: 'N'),
    UnitTile(name: 'moment siły / moment obrotowy', unit: 'niutonometr', symbol: 'N \u00b7 m'),
    UnitTile(name: 'popęd', unit: 'niutonosekunda', symbol: 'N \u00b7 s'),
    UnitTile(name: 'ciśnienie', unit: 'paskal', symbol: 'Pa'),
    UnitTile(name: 'ciśnienie', unit: 'bar (1 bar = 0,1 MPa)', symbol: 'bar'),
    UnitTile(name: 'nacisk / napięcie mechaniczne, moduł Younga', unit: '', symbol: 'N/m\u00b2'),
    UnitTile(name: 'praca / energia', unit: 'dżul (1 J = 1 N\u00b7m = 1 Ws)', symbol: 'J'),
    UnitTile(name: 'moc', unit: 'wat (1 W = 1 J/s = 1 N\u00b7m/s)', symbol: 'W'),
  ]),
  UnitGroup(name: 'Elektryczność', tiles: const []),
  UnitGroup(name: 'Magnetyzm', tiles: const []),
  UnitGroup(name: 'Promieniowanie elektromagnetyczne', tiles: const []),
  UnitGroup(name: 'Optyka', tiles: const []),
  UnitGroup(name: 'Ciepło', tiles: const []),
  UnitGroup(name: 'Chemia', tiles: const []),
  UnitGroup(name: 'Reakcje jądrowe', tiles: const []),
  UnitGroup(name: 'Akustyka', tiles: const []),
  UnitGroup(name: 'Inne', tiles: const []),

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