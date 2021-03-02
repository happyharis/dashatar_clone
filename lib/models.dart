import 'package:flutter/material.dart';

class Role {
  final String text;
  final Color color;
  bool isSelected;

  Role(this.text, {this.color, this.isSelected = false});

  @override
  String toString() =>
      'Role(text: $text, color: $color, isSelected: $isSelected)';
}

class Attribute {
  final String text;
  int points;

  Attribute(this.text, {this.points = 1});
}
