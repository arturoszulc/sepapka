const List<LayingWiresMethod> layingWiresMethods = [
  LayingWiresMethod(
      'A1',
      '\u2022 jednożyłowe\n'
          '\u2022 w termoizolacji\n'
          '\u2022 w rurach lub listwach',
      'assets/images/knowledge_base/wire_ampacity/wire_ampacity_a1.png'),
  LayingWiresMethod(
      'A2',
      '\u2022 wielożyłowe\n'
          '\u2022 w termoizolacji\n'
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
          '\u2022 na ścianie lub pod tynkiem',
      'assets/images/knowledge_base/wire_ampacity/wire_ampacity_b2.png'),
  LayingWiresMethod(
      'C',
      '\u2022 jedno- lub wielożyłowe\n'
          '\u2022 na ścianie, w tynku lub pod tynkiem\n'
          '\u2022 w korytkach kablowych nieperforowanych',
      'assets/images/knowledge_base/wire_ampacity/wire_ampacity_c.png'),
  LayingWiresMethod(
      'E',
      '\u2022 wielożyłowe\n'
          '\u2022 w korytkach perforowanych, wiszące lub podwieszane\n'
          '\u2022 w odległości co najmniej 0,3d od ściany',
      'assets/images/knowledge_base/wire_ampacity/wire_ampacity_e.png'),
  LayingWiresMethod('F',
      '\u2022 jednożyłowe, stykające się\n'
          '\u2022 w korytkach perforowanych, wiszące lub podwieszane\n'
          '\u2022 w odległości co najmniej d od ściany',
      'assets/images/knowledge_base/wire_ampacity/wire_ampacity_f.png'),
  LayingWiresMethod('G',
      '\u2022 jednożyłowe, nie stykające się\n'
          '\u2022 w korytkach perforowanych, wiszące, podwieszane lub na izolatorach\n'
          '\u2022 w odległości co najmniej d od ściany i od siebie',
      'assets/images/knowledge_base/wire_ampacity/wire_ampacity_g.png'),
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
    '6': '43',
    '10': '60',
    '16': '81',
    '25': '107',
    '35': '133',
    '50': '160',
    '70': '204',
    '95': '246',
    '120': '285',
  }, threeWires: {
    '1,5': '16,5',
    '2,5': '22',
    '4': '30',
    '6': '38',
    '10': '53',
    '16': '72',
    '25': '94',
    '35': '117',
    '50': '142',
    '70': '181',
    '95': '219',
    '120': '253',
  }),
  'B2': WireNumber(twoWires: {
    '1,5': '17,5',
    '2,5': '24',
    '4': '32',
    '6': '40',
    '10': '55',
    '16': '73',
    '25': '95',
    '35': '118',
    '50': '141',
    '70': '178',
    '95': '213',
    '120': '246',
  }, threeWires: {
    '1,5': '16',
    '2,5': '21',
    '4': '29',
    '6': '36',
    '10': '49',
    '16': '66',
    '25': '85',
    '35': '105',
    '50': '125',
    '70': '158',
    '95': '190',
    '120': '218',

  }),
  'C': WireNumber(twoWires: {
    '1,5': '21',
    '2,5': '29',
    '4': '38',
    '6': '49',
    '10': '67',
    '16': '90',
    '25': '119',
    '35': '146',
    '50': '178',
    '70': '226',
    '95': '273',
    '120': '317',

  }, threeWires: {
    '1,5': '18,5',
    '2,5': '25',
    '4': '34',
    '6': '43',
    '10': '60',
    '16': '81',
    '25': '102',
    '35': '126',
    '50': '153',
    '70': '195',
    '95': '236',
    '120': '275',

  }),
  'E': WireNumber(twoWires: {
    '1,5': '23',
    '2,5': '32',
    '4': '42',
    '6': '54',
    '10': '74',
    '16': '100',
    '25': '126',
    '35': '157',
    '50': '191',
    '70': '246',
    '95': '299',
    '120': '348',

  }, threeWires: {
    '1,5': '19,5',
    '2,5': '27',
    '4': '36',
    '6': '46',
    '10': '64',
    '16': '85',
    '25': '107',
    '35': '134',
    '50': '162',
    '70': '208',
    '95': '252',
    '120': '293',

  }),
  'F': WireNumber(twoWires: {
    '1,5': '23',
    '2,5': '32',
    '4': '42',
    '6': '54',
    '10': '74',
    '16': '100',
    '25': '139',
    '35': '172',
    '50': '208',
    '70': '266',
    '95': '322',
    '120': '373',

  }, threeWires: {
    '1,5': '19,5',
    '2,5': '27',
    '4': '36',
    '6': '46',
    '10': '64',
    '16': '85',
    '25': '117',
    '35': '145',
    '50': '177',
    '70': '229',
    '95': '280',
    '120': '326',
  }),
  'G': WireNumber(twoWires: {
    '1,5': '23',
    '2,5': '32',
    '4': '42',
    '6': '54',
    '10': '74',
    '16': '100',
    '25': '155',
    '35': '192',
    '50': '232',
    '70': '298',
    '95': '361',
    '120': '420',

  }, threeWires: {
    '1,5': '19,5',
    '2,5': '27',
    '4': '36',
    '6': '46',
    '10': '64',
    '16': '85',
    '25': '138',
    '35': '172',
    '50': '209',
    '70': '269',
    '95': '330',
    '120': '364',
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
