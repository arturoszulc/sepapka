import 'dart:ui';

import 'package:flutter/cupertino.dart';
@immutable
class BMap {
  final String answer;
  final Color color;

  const BMap({
    required this.answer,
    required this.color
  });

  @override
  toString() {
    return '{a: $answer, color: $color';
  }

  BMap copyWith({
    String? answer,
    Color? color,
  }) {
    return BMap(
      answer: answer ?? this.answer,
      color: color ?? this.color,
    );
  }
}