const List<LayingWiresMethod> layingWiresMethods = [
  LayingWiresMethod('A1', '\u2022 jednożyłowe,\n'
      '\u2022 w termoizolacji,\n'
      '\u2022 w rurach lub listwach',
      'assets/images/knowledge_base/wire_ampacity/wire_ampacity_a1.png'),
  LayingWiresMethod('A2', '\u2022 wielożyłowe,\n'
      '\u2022 w termoizolacji,\n'
      '\u2022 w rurach, listwach lub beezpośrednio',
      'assets/images/knowledge_base/wire_ampacity/wire_ampacity_a2.png'),
  LayingWiresMethod(
      'B1',
      '\u2022 jednożyłowe\n'
          '\u2022 w kanałach instalacyjnych lub rurkach\n'
          '\u2022 na ścianie lub pod tynkiem',
      'assets/images/knowledge_base/wire_ampacity/wire_ampacity_b1.png'),
  LayingWiresMethod(
      'B2',
      '\u2022 wielożyłowe\n'
          '\u2022 w kanałach instalacyjnych lub rurkach\n'
          '\u2022 na ścianie lub pod tynkiem', ''),
  LayingWiresMethod(
      'C',
      '\u2022 jedno- lub wielożyłowe,\n'
          '\u2022 na ścianie, w tynku lub pod tynkiem\n'
          '\u2022 w korytku kablowym nieperforowanym', ''),
  LayingWiresMethod('E', 'wielożyłowe, w/na ścianie/podłodze, w rurach/listwach', ''),
  LayingWiresMethod('F', 'wielożyłowe, w/na ścianie/podłodze, w rurach/listwach', ''),
  LayingWiresMethod('G', 'wielożyłowe, w/na ścianie/podłodze, w rurach/listwach', ''),
];

class LayingWiresMethod {
  final String symbol;
  final String description;
  final String assetPath;

  const LayingWiresMethod(this.symbol, this.description, this.assetPath);
}

const Map<String, WireNumber> tableWireAmpacityData = {
  'A1': WireNumber(twoWires: {
    '1,5': '16,5',
    '2,5': '21',
    '4': '28',
    '6': '36',
    '10': '49',
    '16': '65',
    '25': '85',
    '35': '105',
    '50': '126',
    '70': '160',
    '95': '193',
    '120': '223',
  }, threeWires: {
    '1,5': '14,5',
    '2,5': '19',
    '4': '25',
    '6': '33',
    '10': '45',
    '16': '59',
    '25': '77',
    '35': '94',
    '50': '114',
    '70': '144',
    '95': '174',
    '120': '199',
  }),
  'A2': WireNumber(twoWires: {
    '1,5': '16,5',
    '2,5': '19,5',
    '4': '27',
    '6': '34',
    '10': '46',
    '16': '60',
    '25': '80',
    '35': '98',
    '50': '117',
    '70': '147',
    '95': '177',
    '120': '204',
  }, threeWires: {
    '1,5': '14',
    '2,5': '18,5',
    '4': '24',
    '6': '31',
    '10': '41',
    '16': '55',
    '25': '72',
    '35': '88',
    '50': '105',
    '70': '133',
    '95': '159',
    '120': '182',
  }),
  'B1': WireNumber(twoWires: {
    '1,5': '18,5',
    '2,5': '25',
    '4': '34',
    '6': '',
    '10': '',
    '16': '',
    '25': '',
    '35': '',
    '50': '',
    '70': '',
    '95': '',
    '120': '',
  }, threeWires: {
    '1,5': '',
    '2,5': '',
    '4': '',
    '6': '',
    '10': '',
    '16': '',
    '25': '',
    '35': '',
    '50': '',
    '70': '',
    '95': '',
    '120': '',
  }),
  'B2': WireNumber(twoWires: {
    '1,5': '',
    '2,5': '',
    '4': '',
    '6': '',
    '10': '',
    '16': '',
    '25': '',
    '35': '',
    '50': '',
    '70': '',
    '95': '',
    '120': '',
  }, threeWires: {
    '1,5': '',
    '2,5': '',
    '4': '',
    '6': '',
    '10': '',
    '16': '',
    '25': '',
    '35': '',
    '50': '',
    '70': '',
    '95': '',
    '120': '',
  }),
  'C': WireNumber(twoWires: {
    '1,5': '',
    '2,5': '',
    '4': '',
    '6': '',
    '10': '',
    '16': '',
    '25': '',
    '35': '',
    '50': '',
    '70': '',
    '95': '',
    '120': '',
  }, threeWires: {
    '1,5': '',
    '2,5': '',
    '4': '',
    '6': '',
    '10': '',
    '16': '',
    '25': '',
    '35': '',
    '50': '',
    '70': '',
    '95': '',
    '120': '',
  }),
  'E': WireNumber(twoWires: {
    '1,5': '',
    '2,5': '',
    '4': '',
    '6': '',
    '10': '',
    '16': '',
    '25': '',
    '35': '',
    '50': '',
    '70': '',
    '95': '',
    '120': '',
  }, threeWires: {
    '1,5': '',
    '2,5': '',
    '4': '',
    '6': '',
    '10': '',
    '16': '',
    '25': '',
    '35': '',
    '50': '',
    '70': '',
    '95': '',
    '120': '',
  }),
  'F': WireNumber(twoWires: {
    '1,5': '',
    '2,5': '',
    '4': '',
    '6': '',
    '10': '',
    '16': '',
    '25': '',
    '35': '',
    '50': '',
    '70': '',
    '95': '',
    '120': '',
  }, threeWires: {
    '1,5': '',
    '2,5': '',
    '4': '',
    '6': '',
    '10': '',
    '16': '',
    '25': '',
    '35': '',
    '50': '',
    '70': '',
    '95': '',
    '120': '',
  }),
  'G': WireNumber(twoWires: {
    '1,5': '',
    '2,5': '',
    '4': '',
    '6': '',
    '10': '',
    '16': '',
    '25': '',
    '35': '',
    '50': '',
    '70': '',
    '95': '',
    '120': '',
  }, threeWires: {
    '1,5': '',
    '2,5': '',
    '4': '',
    '6': '',
    '10': '',
    '16': '',
    '25': '',
    '35': '',
    '50': '',
    '70': '',
    '95': '',
    '120': '',
  }),
};

class WireNumber {
  final Map<String, String> twoWires;
  final Map<String, String> threeWires;

  const WireNumber({required this.twoWires, required this.threeWires});
}

class Ampacity {
  final String gauge;
  final String current;

  const Ampacity(this.gauge, this.current);
}
