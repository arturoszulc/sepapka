  const Map<String, WireNumber> tableWireAmpacityData = {
    'A1': WireNumber(twoWires: {
      '1,5': '16,5',
      '2,5': '21',
      '4': '28',
    }, threeWires: {
      '1,5': '14,5',
      '2,5': '19',
      '4': '25',
    }),
    'A2': WireNumber(twoWires: {
      '1,5': '16,5',
      '2,5': '19,5',
      '4': '27',
    }, threeWires: {
      '1,5': '14',
      '2,5': '18,5',
      '4': '24',
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
