
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
    UnitTile(name: 'przyspieszenie', unit: 'metr na sekundę do kwadratu', symbol: 'm/s\u00b2'),
  ]),
  UnitGroup(name: 'Mechanika', tiles: const [
    UnitTile(name: 'masa', unit: 'kilogram', symbol: 'kg'),
    UnitTile(name: 'gęstość masy', unit: 'kilogram na metr sześcienny', symbol: 'kg/m\u00b3'),
    UnitTile(name: 'moment bezwładności', unit: 'kilogram razy metr', symbol: 'kg \u00b7 m'),
    UnitTile(name: 'siła', unit: 'niuton', symbol: 'N'),
    UnitTile(name: 'moment siły / moment obrotowy', unit: 'niutonometr', symbol: 'N \u00b7 m'),
    UnitTile(name: 'popęd', unit: 'niutonosekunda', symbol: 'N \u00b7 s'),
    UnitTile(name: 'ciśnienie', unit: 'paskal', symbol: 'Pa'),
    UnitTile(name: 'ciśnienie', unit: 'bar (1 bar = 0,1 MPa)', symbol: 'bar'),
    UnitTile(name: 'nacisk / napięcie mechaniczne, moduł Younga', unit: 'niuton na metr kwadratowy', symbol: 'N/m\u00b2'),
    UnitTile(name: 'praca / energia', unit: 'dżul (1 J = 1 N\u00b7m = 1 Ws)', symbol: 'J'),
    UnitTile(name: 'moc', unit: 'wat (1 W = 1 J/s = 1 N\u00b7m/s)', symbol: 'W'),
  ]),
  UnitGroup(name: 'Elektryczność', tiles: const [
    UnitTile(name: 'ładunek elektryczny', unit: 'kulomb', symbol: 'C'),
    UnitTile(name: 'gęstość powierzchniowa ładunku', unit: 'kulomb na metr kwadratowy', symbol: 'C/m\u00b2'),
    UnitTile(name: 'gęstość przestrzenna ładunku', unit: 'kulomb na metr sześcienny', symbol: 'C/m\u00b3'),
    UnitTile(name: 'napięcie / potencjał elektryczny', unit: 'wolt', symbol: 'V'),
    UnitTile(name: 'natężenie pola elektrycznego', unit: 'wolt na metr (1 V/m = 1 N/C)', symbol: 'V/m'),
    UnitTile(name: 'pojemność elektryczna', unit: 'farad', symbol: 'F'),
    UnitTile(name: 'przenikalność elektryczna', unit: 'farad na metr', symbol: 'F/m'),
    UnitTile(name: 'natężenie prądu', unit: 'amper', symbol: 'A'),
    UnitTile(name: 'gęstość prądu', unit: 'amper na metr kwadratowy', symbol: 'A/m\u00b2'),
    UnitTile(name: 'rezystancja / reaktancja / impedancja', unit: 'om', symbol: '\u03a9'),
    UnitTile(name: 'rezystywność (opór elektryczny właściwy)', unit: 'omometr', symbol: '\u03a9 \u00b7 m'),
    UnitTile(name: 'konduktancja (przewodność elektryczna)', unit: 'simens', symbol: 'S'),
    UnitTile(name: 'konduktywność (przewodność elektryczna właściwa)', unit: 'simens na metr', symbol: 'S/m'),
    UnitTile(name: 'moc elektryczna czynna', unit: 'wat', symbol: 'W'),
    UnitTile(name: 'moc elektryczna bierna', unit: 'war', symbol: 'var'),
    UnitTile(name: 'moc elektryczna pozorna', unit: 'woltamper', symbol: 'VA'),
    UnitTile(name: 'indukcyjność', unit: 'henr', symbol: 'H'),
    UnitTile(name: 'praca / energia elektryczna', unit: 'watogodzina (1 Wh = 1 J)', symbol: 'Wh'),
  ]),
  UnitGroup(name: 'Magnetyzm', tiles: const [
    UnitTile(name: 'przenikalność magnetyczna', unit: 'henr na metr', symbol: 'H/m'),
    UnitTile(name: 'natężenie pola magnetycznego', unit: 'amper na metr', symbol: 'A/m'),
    UnitTile(name: 'strumień magnetyczny', unit: 'weber', symbol: 'Wb'),
    UnitTile(name: 'indukcja magnetyczna', unit: 'tesla', symbol: 'T'),
  ]),
  UnitGroup(name: 'Promieniowanie elektromagnetyczne', tiles: const [
    UnitTile(name: 'energia promieniowania', unit: 'dżul', symbol: 'J'),
    UnitTile(name: 'moc promieniowania', unit: 'wat', symbol: 'W'),
    UnitTile(name: 'natężenie promieniowania', unit: 'wat na steradian', symbol: 'W/sr'),
    UnitTile(name: 'gęstość promieniowania', unit: 'wat na steradian razy metr kwadratowy', symbol: 'W/(sr\u00b7m\u00b2)'),
    UnitTile(name: 'natężenie napromieniowania (irradiancja)', unit: 'wat na metr kwadratowy', symbol: 'W/m\u00b2'),
  ]),
  UnitGroup(name: 'Optyka', tiles: const [
    UnitTile(name: 'światłość', unit: 'kandela', symbol: 'cd'),
    UnitTile(name: 'luminancja (jaskrawość)', unit: 'kandela na metr kwadratowy', symbol: 'cd/m\u00b2'),
    UnitTile(name: 'strumień świetlny', unit: 'lumen', symbol: 'lm'),
    UnitTile(name: 'skuteczność świetlna (wydajność świetlna)', unit: 'lumen na wat', symbol: 'lm/W'),
    UnitTile(name: 'natężenie oświetlenia', unit: 'lux (1 lx = 1 lm/m\u00b2', symbol: 'lx'),
    UnitTile(name: 'współczynnik skupienia soczewek (zdolność skupiająca)', unit: 'dioptria', symbol: 'dpt'),
  ]),
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