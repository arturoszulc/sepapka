import 'dart:ui';

class AMap {
  String answer;
  Color color;

  AMap({
    required this.answer,
    required this.color

  });

  @override
  toString() {
    return '{a: $answer, color: $color';
  }
}