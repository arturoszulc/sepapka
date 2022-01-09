import 'dart:ui';

class BMap {
  String answer;
  Color color;

  BMap({
    required this.answer,
    required this.color

  });

  @override
  toString() {
    return '{a: $answer, color: $color';
  }
}