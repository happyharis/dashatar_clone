import 'package:dashatar_clone/models.dart';
import 'package:flutter/material.dart';

class DashatarNotifier extends ChangeNotifier {
  List<Role> _initRoles = [
    Role('Designer', color: Colors.blue.shade400),
    Role('Developer', color: Colors.green.shade400),
    Role('Manager', color: Colors.amber),
  ];

  Color accentColor;

  List<Role> get roles => _initRoles;

  Color get color => accentColor;

  void updateRole(Role role) {
    _initRoles.forEach((element) {
      if (element.text == role.text) {
        element.isSelected = true;
        accentColor = element.color;
      } else {
        element.isSelected = false;
      }
    });
    _isResetable = true;

    notifyListeners();
  }

  final attributes = [
    Attribute('Strength'),
    Attribute('Agility'),
    Attribute('Wisdom'),
    Attribute('Charisma'),
  ];
  int currentPoints = 8;

  void lowerAttribute(Attribute attribute) {
    if (currentPoints == 8 || attribute.points == 1) return;
    attributes.forEach((element) {
      if (element.text == attribute.text) {
        element.points--;
      }
    });
    currentPoints++;
    _isResetable = true;
    notifyListeners();
  }

  void increaseAttribute(Attribute attribute) {
    if (currentPoints == 0 || attribute.points == 5) return;
    attributes.forEach((element) {
      if (element.text == attribute.text) {
        element.points++;
      }
    });
    currentPoints--;
    _isResetable = true;
    notifyListeners();
  }

  bool _isResetable = false;

  bool get isResetable => _isResetable;

  void reset() {
    _initRoles.forEach((element) => element.isSelected = false);
    attributes.forEach((element) => element.points = 1);
    accentColor = null;
    _isResetable = false;
    notifyListeners();
  }
}
